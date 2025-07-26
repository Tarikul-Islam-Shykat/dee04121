// controllers/math_challenge_controller.dart
import 'dart:ui';

import 'package:get/get.dart';
import 'package:prettyrini/feature/Quiz_game_paths/ui/quiz_level_screen.dart';
import 'package:prettyrini/feature/daily_practice/ui/daily_ui_page.dart';
import 'package:prettyrini/feature/home_page/model/home_model.dart';
import 'package:prettyrini/feature/quiz_page/ui/quiz_ui.dart';

class HomePageController extends GetxController {
  // User data
  final Rx<UserModel> user = UserModel(
    name: "Pasztor Kira",
    coins: 750,
    avatarPath: "assets/images/avatar.png",
  ).obs;

  // Daily challenges data
  final RxList<HomeModel> dailyChallenges = <HomeModel>[
    HomeModel(
      title: "Solve 05 Math Questions",
      subtitle: "by PowerMath Defenders",
      duration: 5,
      questions: 5,
      difficulty: "easy",
    ),
    HomeModel(
      title: "Solve 10 Math Questions",
      subtitle: "by PowerMath Defenders",
      duration: 5,
      questions: 10,
      difficulty: "medium",
    ),
    HomeModel(
      title: "Solve 15 Math Questions",
      subtitle: "by PowerMath Defenders",
      duration: 6,
      questions: 15,
      difficulty: "hard",
    ),
    HomeModel(
      title: "Solve 20 Math Questions",
      subtitle: "by PowerMath Defenders",
      duration: 5,
      questions: 20,
      difficulty: "expert",
    ),
  ].obs;

  // Navigation methods
  void onMathMissionTap() {
    Get.to(QuizLevelScreen());
    Get.snackbar("Math Missions", "Opening Math Missions...");
  }

  void onTimedChallengesTap() {
    Get.to(QuizScreen());
    Get.snackbar("Timed Challenges", "Opening Timed Challenges...");
  }

  void onRewardsTap() {
    Get.snackbar("Rewards", "Opening Rewards section...");
  }

  void onStartQuizTap() {
    Get.to(DailyPracticesPage());
    Get.snackbar("Quiz", "Starting Daily Practice Quiz...");
  }

  void onChallengeTap(HomeModel challenge) {
    Get.snackbar("Challenge", "Starting ${challenge.title}...");
  }

  // Helper method to get challenge icon color based on difficulty
  Color getChallengeIconColor(String difficulty) {
    switch (difficulty) {
      case "easy":
        return const Color(0xFF3ADEFF);
      case "medium":
        return const Color(0xFF1DE5B1);
      case "hard":
        return const Color(0xFFFF873E);
      case "expert":
        return const Color(0xFFFFCD73);
      default:
        return const Color(0xFF3ADEFF);
    }
  }
}
