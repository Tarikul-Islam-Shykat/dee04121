import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/core/global_widegts/custom_text.dart';
import 'package:prettyrini/feature/auth/controller/otp_verification_controller.dart';
import 'package:prettyrini/feature/auth/screen/reset_password.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OtpVerificationController controller =
        Get.put(OtpVerificationController());

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
              _buildTopSection(controller),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 40.h),

                        // Logo
                        _buildLogo(),

                        SizedBox(height: 30.h),

                        // Title and subtitle
                        _buildTitle(),

                        SizedBox(height: 40.h),

                        // OTP Input Fields
                        _buildOtpFields(controller),

                        SizedBox(height: 30.h),

                        // Resend timer
                        _buildResendTimer(controller),

                        SizedBox(height: 40.h),

                        // Apply Code Button
                        _buildApplyCodeButton(controller),

                        SizedBox(height: 16.h),

                        // Send Email Again Button
                        _buildSendEmailAgainButton(controller),

                        SizedBox(height: 20.h),
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

  Widget _buildTopSection(OtpVerificationController controller) {
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

  Widget _buildTitle() {
    return Column(
      children: [
        headingText(
          text: "Enter Verification Code",
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 8.h),
        smallText(
          textAlign: TextAlign.center,
          text:
              'Please check your email. Give correct\nreset 5 digit code here.',
          maxLines: 2,
        ),
      ],
    );
  }

  Widget _buildOtpFields(OtpVerificationController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(5, (index) {
          return Container(
            width: 50.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                TextField(
                  controller: controller.otpControllers[index],
                  focusNode: controller.focusNodes[index],
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  maxLength: 1,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  decoration: InputDecoration(
                    counterText: '',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (value) => controller.onOtpChanged(index, value),
                  onTap: () {
                    controller.otpControllers[index].selection =
                        TextSelection.fromPosition(
                      TextPosition(
                          offset: controller.otpControllers[index].text.length),
                    );
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildResendTimer(OtpVerificationController controller) {
    return Obx(
      () => controller.isResendEnabled.value
          ? const SizedBox.shrink()
          : smallText(
              text: 'Resend code in ${controller.resendTimer.value}s',
              color: Colors.white.withOpacity(0.8),
            ),
    );
  }

  Widget _buildApplyCodeButton(OtpVerificationController controller) {
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
            onTap: () {
              Get.to(() => ResetPassword());
            },
            // controller.isLoading.value || !controller.isOtpComplete.value
            //     ? null
            //     : controller.verifyOtp,
            borderRadius: BorderRadius.circular(12.r),
            splashColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(
                    controller.isOtpComplete.value
                        ? ImagePath.blueBtn // Active button
                        : ImagePath
                            .blueBtn, // You can use a different disabled button image
                  ),
                  fit: BoxFit.cover,
                ),
                // Add overlay for disabled state
                color: controller.isOtpComplete.value
                    ? null
                    : Colors.grey.withOpacity(0.5),
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
                    : normalText(
                        text: "Apply Code",
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSendEmailAgainButton(OtpVerificationController controller) {
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
            onTap:
                controller.isResendEnabled.value && !controller.isLoading.value
                    ? controller.resendOtp
                    : null,
            borderRadius: BorderRadius.circular(12.r),
            splashColor: Colors.white.withOpacity(0.3),
            highlightColor: Colors.white.withOpacity(0.1),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: AssetImage(
                    controller.isResendEnabled.value
                        ? ImagePath
                            .orange_btn // You might want a different color for resend button
                        : ImagePath.orange_btn,
                  ),
                  fit: BoxFit.cover,
                ),
                // Add overlay for disabled state
                color: controller.isResendEnabled.value
                    ? null
                    : Colors.grey.withOpacity(0.5),
              ),
              child: Center(
                child: normalText(
                  text: "Send Email Again",
                  fontWeight: FontWeight.bold,
                  color: controller.isResendEnabled.value
                      ? Colors.white
                      : Colors.white.withOpacity(0.6),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
