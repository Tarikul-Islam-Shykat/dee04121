import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';

// Import your controller
// import 'avatar_controller.dart';

class AvatarController extends GetxController {
  // Selected avatar index (-1 means no selection)
  RxInt selectedAvatarIndex = (-1).obs;

  // List of avatar paths
  final List<String> avatarPaths = [
    ImagePath.av1,
    ImagePath.av2,
    ImagePath.av3,
    ImagePath.av4,
  ];

  // Select avatar method
  void selectAvatar(int index) {
    selectedAvatarIndex.value = index;
  }

  // Check if avatar is selected
  bool isAvatarSelected(int index) {
    return selectedAvatarIndex.value == index;
  }

  // Check if any avatar is selected
  bool get hasSelectedAvatar => selectedAvatarIndex.value != -1;

  // Get selected avatar path
  String? get selectedAvatarPath {
    if (selectedAvatarIndex.value == -1) return null;
    return avatarPaths[selectedAvatarIndex.value];
  }

  // Continue with selected avatar
  void continueWithAvatar() {
    if (hasSelectedAvatar) {
      // Handle navigation or save selected avatar
      print('Selected avatar: ${selectedAvatarPath}');
      // Add your navigation logic here
      // Get.toNamed('/next-screen');
    }
  }
}

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AvatarController controller = Get.put(AvatarController());

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
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        _buildLogo(),
                        SizedBox(height: 20.h),
                        Text(
                          'Choose Your Avatar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 40.h),
                        _buildAvatarGrid(controller),
                        SizedBox(height: 40.h),
                        Obx(() => continueBtn(controller))
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

  Widget _buildLogo() {
    return Image.asset(
      ImagePath.tagLine, // Your PowerMath logo image
      width: 280.w,
      height: 80.h,
      fit: BoxFit.contain,
    );
  }

  Widget _buildAvatarGrid(AvatarController controller) {
    return Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 20.h,
          crossAxisSpacing: 20.w,
          childAspectRatio: 1,
        ),
        itemCount: controller.avatarPaths.length,
        itemBuilder: (context, index) {
          return _buildAvatarItem(controller, index);
        },
      ),
    );
  }

  Widget _buildAvatarItem(AvatarController controller, int index) {
    return Obx(() {
      final isSelected = controller.isAvatarSelected(index);

      return GestureDetector(
        onTap: () => controller.selectAvatar(index),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: isSelected
                ? Border.all(
                    color: Colors.green,
                    width: 4.w,
                  )
                : null,
          ),
          child: Stack(
            children: [
              // Avatar Image
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(controller.avatarPaths[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              // Green tick icon when selected
              if (isSelected)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    alignment: Alignment.center,
                    child: Container(
                      width: 28.w,
                      height: 28.w,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }

  Widget continueBtn(AvatarController controller) {
    return Container(
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
          onTap: controller.hasSelectedAvatar
              ? controller.continueWithAvatar
              : null,
          borderRadius: BorderRadius.circular(12.r),
          splashColor: Colors.white.withOpacity(0.3),
          highlightColor: Colors.white.withOpacity(0.1),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              image: const DecorationImage(
                image: AssetImage(ImagePath.orange_btn),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'Continue',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: controller.hasSelectedAvatar
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
