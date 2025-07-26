import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/settings/model/settings_model.dart';

class ProfileController extends GetxController {
  // User profile data
  final RxString userName = "Pasztor Kira".obs;
  final RxString userAvatar = ImagePath.av1.obs;
  final RxInt userLevel = 22.obs;
  final RxInt userCoins = 2000.obs;

  // Profile menu items - Only the two from your image
  final List<ProfileMenuItem> profileMenuItems = [
    ProfileMenuItem(
      title: "Edit Profile",
      icon: Icons.person_outline,
      onTap: () => (),
    ),
    ProfileMenuItem(
      title: "Change Password",
      icon: Icons.lock_outline,
      onTap: () => (),
    ),
  ];

  // Navigation methods
  void _editProfile() {
    print("Navigate to Edit Profile");
    // Get.toNamed('/edit-profile');
  }

  void _changePassword() {
    print("Navigate to Change Password");
    // Get.toNamed('/change-password');
  }

  void _notifications() {
    print("Navigate to Notifications");
    // Get.toNamed('/notifications');
  }

  void _privacyPolicy() {
    print("Navigate to Privacy Policy");
    // Get.toNamed('/privacy-policy');
  }

  void _termsConditions() {
    print("Navigate to Terms & Conditions");
    // Get.toNamed('/terms-conditions');
  }

  void _helpSupport() {
    print("Navigate to Help & Support");
    // Get.toNamed('/help-support');
  }

  void _logout() {
    Get.dialog(
      AlertDialog(
        title: Text("Logout"),
        content: Text("Are you sure you want to logout?"),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              // Handle logout logic
              print("User logged out");
              // Get.offAllNamed('/login');
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }

  // Update user data
  void updateUserName(String name) {
    userName.value = name;
  }

  void updateUserAvatar(String avatarPath) {
    userAvatar.value = avatarPath;
  }
}
