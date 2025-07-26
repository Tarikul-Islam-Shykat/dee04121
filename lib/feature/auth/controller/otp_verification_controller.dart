import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class OtpVerificationController extends GetxController {
  // Text controllers for each OTP field
  final List<TextEditingController> otpControllers = List.generate(
    5,
    (index) => TextEditingController(),
  );
  
  // Focus nodes for each OTP field
  final List<FocusNode> focusNodes = List.generate(
    5,
    (index) => FocusNode(),
  );
  
  // Observable variables
  final RxBool isLoading = false.obs;
  final RxBool isResendEnabled = false.obs;
  final RxInt resendTimer = 60.obs;
  final RxString otpCode = ''.obs;
  final RxBool isOtpComplete = false.obs;
  final RxString email = ''.obs;
  
  Timer? _timer;
  
  @override
  void onInit() {
    super.onInit();
    // Get email from arguments if passed
    if (Get.arguments != null) {
      email.value = Get.arguments['email'] ?? '';
    }
    startResendTimer();
  }
  
  // Start countdown timer for resend button
  void startResendTimer() {
    isResendEnabled.value = false;
    resendTimer.value = 60;
    
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        isResendEnabled.value = true;
        timer.cancel();
      }
    });
  }
  
  // Handle OTP input change
  void onOtpChanged(int index, String value) {
    otpControllers[index].text = value;
    
    // Move to next field if value is entered
    if (value.isNotEmpty && index < 4) {
      focusNodes[index + 1].requestFocus();
    }
    
    // Move to previous field if value is deleted
    if (value.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
    
    // Update complete OTP code
    updateOtpCode();
  }
  
  // Handle backspace key
  void onBackspacePressed(int index) {
    if (otpControllers[index].text.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
      otpControllers[index - 1].clear();
    } else {
      otpControllers[index].clear();
    }
    updateOtpCode();
  }
  
  // Update complete OTP code
  void updateOtpCode() {
    String code = '';
    for (var controller in otpControllers) {
      code += controller.text;
    }
    otpCode.value = code;
    isOtpComplete.value = code.length == 5;
  }
  
  // Clear all OTP fields
  void clearOtp() {
    for (var controller in otpControllers) {
      controller.clear();
    }
    otpCode.value = '';
    isOtpComplete.value = false;
    focusNodes[0].requestFocus();
  }
  
  // Verify OTP
  Future<void> verifyOtp() async {
    if (!isOtpComplete.value) {
      Get.snackbar(
        'Error',
        'Please enter complete 5-digit code',
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
      
      // Validate OTP (replace with actual API call)
      if (await _validateOtp(otpCode.value)) {
        Get.snackbar(
          'Success',
          'Email verified successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        
        // Navigate to next screen (e.g., reset password or home)
        // Get.offAllNamed('/reset-password');
        // or Get.offAllNamed('/home');
        
      } else {
        Get.snackbar(
          'Error',
          'Invalid verification code. Please try again.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        clearOtp();
      }
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Verification failed. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Resend OTP
  Future<void> resendOtp() async {
    if (!isResendEnabled.value) return;
    
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Clear current OTP
      clearOtp();
      
      // Restart timer
      startResendTimer();
      
      Get.snackbar(
        'Success',
        'Verification code sent to your email',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to resend code. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Mock OTP validation (replace with actual API call)
  Future<bool> _validateOtp(String otp) async {
    // Mock validation - replace with actual API call
    // For demo purposes, accept "12345" as valid OTP
    return otp == "12345";
  }
  
  // Navigate back
  void goBack() {
    Get.back();
  }
  
  @override
  void onClose() {
    // Dispose controllers and focus nodes
    for (var controller in otpControllers) {
      controller.dispose();
    }
    for (var focusNode in focusNodes) {
      focusNode.dispose();
    }
    _timer?.cancel();
    super.onClose();
  }
}