import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavController extends GetxController
    with GetSingleTickerProviderStateMixin {
  var currentIndex = 0.obs;
  late AnimationController fabAnimationController;
  late Animation<double> fabScaleAnimation;

  @override
  void onInit() {
    super.onInit();
    fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    fabScaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.85,
    ).animate(CurvedAnimation(
      parent: fabAnimationController,
      curve: Curves.elasticOut,
    ));
  }

  void changeTabIndex(int index) {
    if (currentIndex.value != index) {
      currentIndex.value = index;

      // Animate FAB when middle button is pressed
      if (index == 2) {
        fabAnimationController.forward().then((_) {
          fabAnimationController.reverse();
        });
      }
    }
  }

  // Navigation methods for all 5 screens
  void goToHome() => changeTabIndex(0); // Home
  void goToPractice() => changeTabIndex(1); // Daily Practice
  void goToLeaderboard() => changeTabIndex(2); // Leaderboard (FAB)
  void goToProgress() => changeTabIndex(3); // Progress Report
  void goToProfile() => changeTabIndex(4); // Account/Profile

  void onFabPressed() {
    changeTabIndex(2); // Go to LeaderBoard (middle screen)
  }

  // Helper method to get screen title
  String get currentScreenTitle {
    switch (currentIndex.value) {
      case 0:
        return 'Home';
      case 1:
        return 'Practice';
      case 2:
        return 'Leaderboard';
      case 3:
        return 'Progress';
      case 4:
        return 'Profile';
      default:
        return 'App';
    }
  }

  // Helper method to check if current screen is accessible via bottom nav
  bool get isBottomNavScreen {
    return currentIndex.value >= 0 && currentIndex.value <= 4;
  }

  @override
  void onClose() {
    fabAnimationController.dispose();
    super.onClose();
  }
}
