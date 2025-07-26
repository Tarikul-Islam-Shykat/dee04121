import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/leader_board/model/leader_board_user.dart';

class LeaderboardController extends GetxController {
  // Top 3 users (podium)
  final RxList<LeaderboardUser> topThreeUsers = <LeaderboardUser>[].obs;

  // Other users in the leaderboard
  final RxList<LeaderboardUser> otherUsers = <LeaderboardUser>[].obs;

  // Current user data
  final Rx<LeaderboardUser> currentUser = LeaderboardUser(
    name: "Your Score",
    level: 22,
    coins: 2000,
    avatarPath: ImagePath.av4,
    rank: 102,
    isUp: false,
  ).obs;

  @override
  void onInit() {
    super.onInit();
    loadLeaderboardData();
  }

  void loadLeaderboardData() {
    // Top 3 users data
    topThreeUsers.value = [
      LeaderboardUser(
        name: "Floyd Miles",
        level: 22,
        coins: 2000,
        avatarPath: ImagePath.av2,
        rank: 2,
        isUp: true,
      ),
      LeaderboardUser(
        name: "Pasztor Kira",
        level: 22,
        coins: 2000,
        avatarPath: ImagePath.av1,
        rank: 1,
        isUp: true,
      ),
      LeaderboardUser(
        name: "Theresa Webb",
        level: 22,
        coins: 2000,
        avatarPath: ImagePath.av3,
        rank: 3,
        isUp: true,
      ),
    ];

    // Other users data
    otherUsers.value = [
      LeaderboardUser(
        name: "Darrell Steward",
        level: 22,
        coins: 2000,
        avatarPath: ImagePath.av4,
        rank: 4,
        isUp: true,
      ),
      LeaderboardUser(
        name: "Darrell Steward",
        level: 22,
        coins: 2000,
        avatarPath: ImagePath.av1,
        rank: 5,
        isUp: false,
      ),
      LeaderboardUser(
        name: "Darrell Steward",
        level: 22,
        coins: 2000,
        avatarPath: ImagePath.av2,
        rank: 6,
        isUp: true,
      ),
    ];
  }

  // Get crown for top 3
  bool shouldShowCrown(int rank) {
    return rank == 1;
  }

  // Get podium colors
  List<Color> getPodiumColors(int rank) {
    switch (rank) {
      case 1:
        return [Color(0xFFFFD700), Color(0xFFFFA500)]; // Gold gradient
      case 2:
        return [Color(0xFFFF69B4), Color(0xFFFF1493)]; // Pink gradient
      case 3:
        return [Color(0xFF00BFFF), Color(0xFF1E90FF)]; // Blue gradient
      default:
        return [Color(0xFFFFD700), Color(0xFFFFA500)];
    }
  }

  // Get podium size (winner is larger)
  double getPodiumSize(int rank) {
    return rank == 1 ? 100.0 : 80.0;
  }

  // Get rank position offset (winner is higher)
  double getRankOffset(int rank) {
    return rank == 1 ? -20.0 : 0.0;
  }
}
