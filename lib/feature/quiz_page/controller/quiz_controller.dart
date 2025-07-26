import 'package:get/get.dart';
import 'package:prettyrini/feature/quiz_page/controller/quiz_dummy_data.dart';
import 'package:prettyrini/feature/quiz_page/model/quiz_model.dart';

class QuizController extends GetxController {
  // Observable variables
  final RxList<QuestionModel> _questions = <QuestionModel>[].obs;
  final RxInt _currentQuestionIndex = 0.obs;
  final RxInt _selectedAnswerIndex = (-1).obs;
  final RxBool _showAnswer = false.obs;
  final RxInt _score = 0.obs;
  final RxBool _quizCompleted = false.obs;

  // Getters
  List<QuestionModel> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex.value;
  int get selectedAnswerIndex => _selectedAnswerIndex.value;
  bool get showAnswer => _showAnswer.value;
  int get score => _score.value;
  bool get quizCompleted => _quizCompleted.value;

  QuestionModel get currentQuestion => _questions[_currentQuestionIndex.value];
  int get totalQuestions => _questions.length;
  double get progress => (_currentQuestionIndex.value + 1) / _questions.length;

  @override
  void onInit() {
    super.onInit();
    _loadQuestions();
  }

  void _loadQuestions() {
    _questions.value = QuizData.getQuestions();
  }

  void selectAnswer(int index) {
    if (_showAnswer.value) return;
    _selectedAnswerIndex.value = index;
  }

  void handleNext() {
    if (!_showAnswer.value && _selectedAnswerIndex.value != -1) {
      // Show the correct answer
      _showAnswer.value = true;

      // Check if selected answer is correct and update score
      if (currentQuestion.options[_selectedAnswerIndex.value].isCorrect) {
        _score.value++;
      }
    } else if (_showAnswer.value) {
      // Move to next question or complete quiz
      if (_currentQuestionIndex.value < _questions.length - 1) {
        _currentQuestionIndex.value++;
        _selectedAnswerIndex.value = -1;
        _showAnswer.value = false;
      } else {
        _quizCompleted.value = true;
      }
    }
  }

  void resetQuiz() {
    _currentQuestionIndex.value = 0;
    _selectedAnswerIndex.value = -1;
    _showAnswer.value = false;
    _score.value = 0;
    _quizCompleted.value = false;
  }

  String get nextButtonText {
    if (!_showAnswer.value) {
      return 'Check Answer';
    } else if (_currentQuestionIndex.value == _questions.length - 1) {
      return 'Finish Quiz';
    } else {
      return 'Next →';
    }
  }

  bool get isNextButtonEnabled {
    return _showAnswer.value || _selectedAnswerIndex.value != -1;
  }

  String getScoreMessage() {
    if (_score.value >= 8) return "🌟 Excellent!";
    if (_score.value >= 6) return "👏 Great job!";
    if (_score.value >= 4) return "👍 Good try!";
    return "💪 Keep practicing!";
  }
}
