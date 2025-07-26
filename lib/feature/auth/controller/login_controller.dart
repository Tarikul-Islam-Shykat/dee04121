import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isEmailValid = true.obs;
  final RxBool isPasswordValid = true.obs;
  
  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }
  
  // Validate email
  bool validateEmail(String email) {
    if (email.isEmpty) {
      isEmailValid.value = false;
      return false;
    }
    
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    isEmailValid.value = emailRegex.hasMatch(email);
    return isEmailValid.value;
  }
  
  // Validate password
  bool validatePassword(String password) {
    if (password.isEmpty || password.length < 6) {
      isPasswordValid.value = false;
      return false;
    }
    isPasswordValid.value = true;
    return true;
  }
  
  // Handle login
  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    
    if (!validateEmail(email) || !validatePassword(password)) {
      Get.snackbar(
        'Error',
        'Please enter valid email and password',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // Handle login logic here
      Get.snackbar(
        'Success',
        'Login successful!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate to next screen
      // Get.offAllNamed('/home');
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Login failed. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Handle forgot password
  void forgotPassword() {
    Get.snackbar(
      'Info',
      'Password reset link will be sent to your email',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
    );
    // Implement forgot password logic
  }
  
  // Navigate back
  void goBack() {
    Get.back();
  }
  
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}