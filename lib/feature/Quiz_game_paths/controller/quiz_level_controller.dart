import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/Quiz_game_paths/model/quiz_level_model.dart';

class QuizLevelController extends GetxController {
  var quizLevels = <QuizLevel>[].obs;
  var isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuizLevels();
  }

  // Dummy JSON data - replace this with your API call
  void loadQuizLevels() {
    isLoading.value = true;

    // Simulate API delay
    Future.delayed(const Duration(milliseconds: 500), () {
      final dummyData = [
        {
          "id": 1,
          "title": "TECH JUNGLE",
          "imageAsset": "assets/images/img_1.png",
          "isCompleted": true,
          "isUnlocked": true
        },
        {
          "id": 2,
          "title": "GALACTIC VISTA",
          "imageAsset": "assets/images/img_2.png",
          "isCompleted": true,
          "isUnlocked": true
        },
        {
          "id": 3,
          "title": "HIGH-TECH UNDERWATER BASE",
          "imageAsset": "assets/images/img_1.png",
          "isCompleted": false,
          "isUnlocked": true
        },
        {
          "id": 4,
          "title": "GAMING WORKSHOP",
          "imageAsset": "assets/images/img_2.png",
          "isCompleted": false,
          "isUnlocked": true
        },
        {
          "id": 5,
          "title": "CYBER SPACE",
          "imageAsset": "assets/images/img_1.png",
          "isCompleted": false,
          "isUnlocked": false
        },
        {
          "id": 6,
          "title": "ROBOT FACTORY",
          "imageAsset": "assets/images/img_2.png",
          "isCompleted": false,
          "isUnlocked": false
        },
        {
          "id": 7,
          "title": "DIGITAL WORLD",
          "imageAsset": "assets/images/img_1.png",
          "isCompleted": false,
          "isUnlocked": false
        },
        {
          "id": 8,
          "title": "AI LABORATORY",
          "imageAsset": "assets/images/img_2.png",
          "isCompleted": false,
          "isUnlocked": false
        },
        {
          "id": 9,
          "title": "VIRTUAL REALITY",
          "imageAsset": "assets/images/img_1.png",
          "isCompleted": false,
          "isUnlocked": false
        },
        {
          "id": 10,
          "title": "QUANTUM REALM",
          "imageAsset": "assets/images/img_2.png",
          "isCompleted": false,
          "isUnlocked": false
        }
      ];

      quizLevels.value =
          dummyData.map((json) => QuizLevel.fromJson(json)).toList();
      isLoading.value = false;
    });
  }

  // Method to handle level tap
  void onLevelTap(QuizLevel level) {
    print("Tapped on level: ${level.title}");
    print("Level ID: ${level.id}");
    print("Is Unlocked: ${level.isUnlocked}");
    print("Is Completed: ${level.isCompleted}");

    if (level.isUnlocked) {
      // Navigate to quiz screen or perform action
      Get.snackbar(
        "Level Selected",
        level.title,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.blue.withOpacity(0.8),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        "Level Locked",
        "Complete previous levels to unlock",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withOpacity(0.8),
        colorText: Colors.white,
      );
    }
  }

  // Method to refresh data (for pull to refresh)
  Future<void> refreshData() async {
    loadQuizLevels();
  }
}
