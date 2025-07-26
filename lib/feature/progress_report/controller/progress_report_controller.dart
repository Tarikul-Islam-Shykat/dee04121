import 'package:get/get.dart';

class ProgressData {
  final String title;
  final int correct;
  final int skipped;
  final int incorrect;
  final int total;

  ProgressData({
    required this.title,
    required this.correct,
    required this.skipped,
    required this.incorrect,
    required this.total,
  });

  double get correctPercentage => (correct / total) * 100;
  double get skippedPercentage => (skipped / total) * 100;
  double get incorrectPercentage => (incorrect / total) * 100;
}

class ProgressReportController extends GetxController {
  // Observable list of progress data
  final RxList<ProgressData> progressList = <ProgressData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadProgressData();
  }

  void loadProgressData() {
    // Dummy data for the progress report
    progressList.value = [
      ProgressData(
        title: 'Addition',
        correct: 200,
        skipped: 50,
        incorrect: 150,
        total: 400,
      ),
      ProgressData(
        title: 'Subtraction',
        correct: 200,
        skipped: 50,
        incorrect: 150,
        total: 400,
      ),
      ProgressData(
        title: 'Multiplication',
        correct: 100,
        skipped: 50,
        incorrect: 150,
        total: 300,
      ),
      ProgressData(
        title: 'Division',
        correct: 200,
        skipped: 50,
        incorrect: 150,
        total: 400,
      ),
    ];
  }

  // Method to refresh data
  void refreshData() {
    loadProgressData();
  }

  // Method to get specific progress by index
  ProgressData getProgressByIndex(int index) {
    return progressList[index];
  }

  // Method to get total statistics
  Map<String, int> getTotalStats() {
    int totalCorrect = 0;
    int totalSkipped = 0;
    int totalIncorrect = 0;
    int totalQuestions = 0;

    for (var progress in progressList) {
      totalCorrect += progress.correct;
      totalSkipped += progress.skipped;
      totalIncorrect += progress.incorrect;
      totalQuestions += progress.total;
    }

    return {
      'correct': totalCorrect,
      'skipped': totalSkipped,
      'incorrect': totalIncorrect,
      'total': totalQuestions,
    };
  }
}
