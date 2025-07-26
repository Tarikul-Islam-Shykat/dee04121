import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prettyrini/feature/auth/screen/login_screen.dart';

class ResetPasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final RxBool isLoading = false.obs;
  final RxBool isPasswordVisible = false.obs;
  final RxBool isNewPasswordVisible = false.obs;

  final RxBool isEmailValid = true.obs;
  final RxBool isPasswordValid = true.obs;

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;

    isNewPasswordVisible.value = !isNewPasswordVisible.value;
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
    final newPassword = newPasswordController.text.trim();
    final comfirmPassword = passwordController.text.trim();

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

      Get.to(LoginPage());

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

  // Navigate back
  void goBack() {
    Get.back();
  }

  @override
  void onClose() {
    newPasswordController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
