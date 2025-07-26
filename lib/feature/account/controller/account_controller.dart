// controllers/account_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/account/model/account_model.dart';
import 'package:prettyrini/feature/settings/ui/settings_screen.dart';

class AccountController extends GetxController {
  // Account data
  final Rx<AccountModel> account = AccountModel(
    name: "Pasztor Kira",
    avatarPath: "assets/images/av1.png",
    rank: 102,
    level: 7,
    coins: 750,
    currentXp: 750,
    maxXp: 800,
    nextLevel: "Next Level",
  ).obs;

  // Stats cards data
  final RxList<StatsCardModel> statsCards = <StatsCardModel>[
    StatsCardModel(
      title: "Rank",
      value: "102",
      gradient: "blue",
      icon: Icons.emoji_events,
    ),
    StatsCardModel(
      title: "Level",
      value: "07",
      gradient: "green",
      icon: Icons.trending_up,
    ),
    StatsCardModel(
      title: "Coins",
      value: "750",
      gradient: "orange",
      icon: Icons.monetization_on,
    ),
  ].obs;

  // Progress percentage for XP bar
  double get progressPercentage {
    return (account.value.currentXp / account.value.maxXp).clamp(0.0, 1.0);
  }

  // Navigation methods
  void onSettingsTap() {
    Get.to(SettingsScreen());
    Get.snackbar("Settings", "Opening settings...");
  }

  void onEditProfileTap() {
    Get.snackbar("Edit Profile", "Opening profile editor...");
  }

  void onStatCardTap(StatsCardModel card) {
    Get.snackbar(card.title, "Viewing ${card.title} details...");
  }

  // Helper method to get gradient colors based on type
  List<Color> getGradientColors(String gradient) {
    switch (gradient) {
      case "blue":
        return [const Color(0xFF3ADEFF), const Color(0xFF0087B7)];
      case "green":
        return [const Color(0xFF1DE5B1), const Color(0xFF1BA570)];
      case "orange":
        return [const Color(0xFFFF873E), const Color(0xFFFF5344)];
      default:
        return [const Color(0xFF3ADEFF), const Color(0xFF0087B7)];
    }
  }
}
