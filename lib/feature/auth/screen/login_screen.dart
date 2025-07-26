import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/auth/controller/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.bg), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Top section with back button and logo
              //   _buildTopSection(controller),

              // Expanded content area
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        _buildLogo(),

                        SizedBox(height: 20.h),

                        // Subtitle
                        _buildSubtitle(),

                        SizedBox(height: 40.h),

                        // Email Input Field
                        _buildEmailField(controller),

                        SizedBox(height: 16.h),

                        // Password Input Field
                        _buildPasswordField(controller),

                        SizedBox(height: 8.h),

                        // Forgot Password
                        _buildForgotPassword(controller),

                        SizedBox(height: 40.h),

                        // Age confirmation and terms
                        _buildTermsText(),

                        SizedBox(height: 24.h),

                        // Login Button
                        _buildLoginButtonWithCustomSplash(controller),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopSection(LoginController controller) {
    return Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // Back Button
          GestureDetector(
            onTap: controller.goBack,
            child: Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
                size: 18.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogo() {
    return Image.asset(
      ImagePath.tagLine, // Your PowerMath logo image
      width: 280.w,
      height: 80.h,
      fit: BoxFit.contain,
    );
  }

  Widget _buildSubtitle() {
    return Column(
      children: [
        Text(
          'Log In Your Account',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Start your journey in powermath\ndefenders fun way',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 16.sp,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildEmailField(LoginController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => controller.validateEmail(value),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: 'Enter Email Here',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: controller.isEmailValid.value
                    ? Colors.transparent
                    : Colors.red,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: controller.isEmailValid.value
                    ? const Color(0xFF00BCD4)
                    : Colors.red,
                width: 2,
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(LoginController controller) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextField(
          controller: controller.passwordController,
          obscureText: !controller.isPasswordVisible.value,
          onChanged: (value) => controller.validatePassword(value),
          style: TextStyle(
            fontSize: 16.sp,
            color: Colors.black87,
          ),
          decoration: InputDecoration(
            hintText: 'Enter Password Here',
            hintStyle: TextStyle(
              color: Colors.grey[400],
              fontSize: 16.sp,
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: controller.isPasswordValid.value
                    ? Colors.transparent
                    : Colors.red,
                width: 1.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(
                color: controller.isPasswordValid.value
                    ? const Color(0xFF00BCD4)
                    : Colors.red,
                width: 2,
              ),
            ),
            suffixIcon: GestureDetector(
              onTap: controller.togglePasswordVisibility,
              child: Padding(
                padding: EdgeInsets.all(12.w),
                child: Icon(
                  controller.isPasswordVisible.value
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: Colors.grey[600],
                  size: 20.sp,
                ),
              ),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 16.h,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPassword(LoginController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: controller.forgotPassword,
          child: Text(
            'Forgot Password?',
            style: TextStyle(
              color: const Color(0xFF00BCD4),
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsText() {
    return Text.rich(
      TextSpan(
        style: TextStyle(
          fontSize: 12.sp,
          color: Colors.white.withOpacity(0.8),
          height: 1.4,
        ),
        children: [
          const TextSpan(
              text:
                  'By continuing, you confirm that you are 6 years or older\nand agree to our '),
          TextSpan(
            text: 'Terms & Conditions',
            style: TextStyle(
              color: const Color(0xFF00BCD4),
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFF00BCD4),
            ),
          ),
          const TextSpan(text: ' and '),
          TextSpan(
            text: 'Privacy Policy',
            style: TextStyle(
              color: const Color(0xFF00BCD4),
              decoration: TextDecoration.underline,
              decorationColor: const Color(0xFF00BCD4),
            ),
          ),
          const TextSpan(text: '.'),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginButtonWithCustomSplash(LoginController controller) {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 54.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          child: InkWell(
            onTap: controller.isLoading.value ? null : controller.login,
            borderRadius: BorderRadius.circular(12.r),
            splashColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: const DecorationImage(
                  image: AssetImage(ImagePath.blueBtn),
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: controller.isLoading.value
                    ? SizedBox(
                        width: 24.w,
                        height: 24.w,
                        child: const CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
