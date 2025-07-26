import 'dart:math';

import 'package:get/get.dart';
import 'package:prettyrini/feature/daily_practice_quiz_page/model/queston_model_daily.dart';

class DailyQuizController extends GetxController {
  var currentQuestion = Rx<QuestonModelDaily?>(null);
  var selectedAnswer = Rx<int?>(null);
  var isAnswered = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadQuestion();
  }

  void loadQuestion() {
    // Dummy data - replace with API call
    currentQuestion.value = QuestonModelDaily(
      leftNumber: 5,
      rightNumber: 5,
      operation: '+',
      options: [5, 12, 10, 15],
      correctAnswer: 10,
    );
  }

  void selectAnswer(int answer) {
    selectedAnswer.value = answer;
    isAnswered.value = true;
  }

  void nextQuestion() {
    // Generate new random question
    final random = Get.put(Random());
    final left = random.nextInt(100) + 1;
    final right = random.nextInt(100) + 1;
    final correctAnswer = left + right;

    // Generate wrong options
    final options = <int>[correctAnswer];
    while (options.length < 4) {
      final wrongAnswer = correctAnswer + random.nextInt(20) - 10;
      if (wrongAnswer > 0 && !options.contains(wrongAnswer)) {
        options.add(wrongAnswer);
      }
    }
    options.shuffle();

    currentQuestion.value = QuestonModelDaily(
      leftNumber: left,
      rightNumber: right,
      operation: '+',
      options: options,
      correctAnswer: correctAnswer,
    );

    selectedAnswer.value = null;
    isAnswered.value = false;
  }

  bool isCorrectAnswer(int answer) {
    return answer == currentQuestion.value?.correctAnswer;
  }
}
