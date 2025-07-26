import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/daily_practice/ui/daily_ui_page.dart';
import 'package:prettyrini/feature/daily_practice_quiz_page/ui/daily_quiz_screen.dart';

class DailyPracticesController extends GetxController {
  final RxList<PracticeItem> practiceItems = <PracticeItem>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializePracticeItems();
  }

  void _initializePracticeItems() {
    practiceItems.assignAll([
      PracticeItem(
        id: 1,
        title: 'Addition',
        description:
            'Boost Your Kid\'s Math Skills with Fun Addition Quizzes and More!',
        icon: Icons.add,
        backgroundColor: const Color(0xFF9FB5C0),
        imagePath: ImagePath.addition,
        practiceType: PracticeType.addition,
      ),
      PracticeItem(
        id: 2,
        title: 'Subtraction',
        description:
            'Master Subtraction and More with Fun, Interactive Math Quizzes!',
        icon: Icons.remove,
        backgroundColor: const Color(0xFFF6ECEA),
        imagePath: ImagePath.substraction,
        practiceType: PracticeType.subtraction,
      ),
      PracticeItem(
        id: 3,
        title: 'Multiplication',
        description:
            'Supercharge Your Kid\'s Multiplication Skills with Fun and Engaging Quizzes!',
        icon: Icons.close,
        backgroundColor: const Color(0xFFF6F1EE),
        imagePath: ImagePath.multiplication,
        practiceType: PracticeType.multiplication,
      ),
      PracticeItem(
        id: 4,
        title: 'Division',
        description: 'Make Division Fun and Easy with Engaging Math Quizzes!',
        icon: Icons.more_horiz,
        backgroundColor: const Color(0xFF9FB5C0),
        imagePath: ImagePath.division,
        practiceType: PracticeType.division,
      ),
    ]);
  }

  // Handle card tap
  void onPracticeCardTap(PracticeItem item) {
    Get.to(DailyQuizScreen());

    print('Tapped on ${item.title}');
    // Add navigation logic here
    // Get.toNamed('/practice', arguments: item);
  }

  // Get practice item by type
  PracticeItem? getPracticeItemByType(PracticeType type) {
    return practiceItems.firstWhereOrNull((item) => item.practiceType == type);
  }

  // Update practice item
  void updatePracticeItem(int id, PracticeItem updatedItem) {
    final index = practiceItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      practiceItems[index] = updatedItem;
    }
  }
}

// Data Models
class PracticeItem {
  final int id;
  final String title;
  final String description;
  final IconData icon;
  final Color backgroundColor;
  final String imagePath;
  final PracticeType practiceType;

  PracticeItem({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.backgroundColor,
    required this.imagePath,
    required this.practiceType,
  });

  PracticeItem copyWith({
    int? id,
    String? title,
    String? description,
    IconData? icon,
    Color? backgroundColor,
    String? imagePath,
    PracticeType? practiceType,
  }) {
    return PracticeItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      icon: icon ?? this.icon,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      imagePath: imagePath ?? this.imagePath,
      practiceType: practiceType ?? this.practiceType,
    );
  }
}

enum PracticeType {
  addition,
  subtraction,
  multiplication,
  division,
}
