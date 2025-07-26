import 'package:prettyrini/feature/quiz_page/model/quiz_model.dart';

class QuizData {
  static List<QuestionModel> getQuestions() {
    return [
      QuestionModel(
        id: 1,
        question:
            "Tom has 5 apples. He buys 3 more. How many apples does he have now?",
        options: [
          OptionModel(label: "A", value: "05", isCorrect: false),
          OptionModel(label: "B", value: "12", isCorrect: false),
          OptionModel(label: "C", value: "08", isCorrect: true),
          OptionModel(label: "D", value: "15", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 2,
        question:
            "Sarah has 3 balloons. Mom gives her 2 more. How many balloons does Sarah have?",
        options: [
          OptionModel(label: "A", value: "04", isCorrect: false),
          OptionModel(label: "B", value: "05", isCorrect: true),
          OptionModel(label: "C", value: "06", isCorrect: false),
          OptionModel(label: "D", value: "07", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 3,
        question: "Count the stars: ⭐⭐⭐⭐⭐⭐ How many stars are there?",
        options: [
          OptionModel(label: "A", value: "05", isCorrect: false),
          OptionModel(label: "B", value: "06", isCorrect: true),
          OptionModel(label: "C", value: "07", isCorrect: false),
          OptionModel(label: "D", value: "08", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 4,
        question:
            "Ben has 2 toy cars. Dad buys him 4 more cars. How many cars does Ben have now?",
        options: [
          OptionModel(label: "A", value: "05", isCorrect: false),
          OptionModel(label: "B", value: "06", isCorrect: true),
          OptionModel(label: "C", value: "07", isCorrect: false),
          OptionModel(label: "D", value: "08", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 5,
        question: "How many fingers do you have on one hand? ✋",
        options: [
          OptionModel(label: "A", value: "04", isCorrect: false),
          OptionModel(label: "B", value: "05", isCorrect: true),
          OptionModel(label: "C", value: "06", isCorrect: false),
          OptionModel(label: "D", value: "03", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 6,
        question:
            "Lisa has 4 cookies. She eats 1 cookie. How many cookies are left?",
        options: [
          OptionModel(label: "A", value: "02", isCorrect: false),
          OptionModel(label: "B", value: "03", isCorrect: true),
          OptionModel(label: "C", value: "04", isCorrect: false),
          OptionModel(label: "D", value: "05", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 7,
        question: "Count the hearts: ❤️❤️❤️❤️ How many hearts do you see?",
        options: [
          OptionModel(label: "A", value: "03", isCorrect: false),
          OptionModel(label: "B", value: "04", isCorrect: true),
          OptionModel(label: "C", value: "05", isCorrect: false),
          OptionModel(label: "D", value: "06", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 8,
        question: "What is 1 + 1?",
        options: [
          OptionModel(label: "A", value: "01", isCorrect: false),
          OptionModel(label: "B", value: "02", isCorrect: true),
          OptionModel(label: "C", value: "03", isCorrect: false),
          OptionModel(label: "D", value: "04", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 9,
        question:
            "Max has 7 stickers. He gives away 3 stickers. How many stickers does he have left?",
        options: [
          OptionModel(label: "A", value: "03", isCorrect: false),
          OptionModel(label: "B", value: "04", isCorrect: true),
          OptionModel(label: "C", value: "05", isCorrect: false),
          OptionModel(label: "D", value: "06", isCorrect: false),
        ],
      ),
      QuestionModel(
        id: 10,
        question: "What comes after the number 8?",
        options: [
          OptionModel(label: "A", value: "07", isCorrect: false),
          OptionModel(label: "B", value: "08", isCorrect: false),
          OptionModel(label: "C", value: "09", isCorrect: true),
          OptionModel(label: "D", value: "10", isCorrect: false),
        ],
      ),
    ];
  }
}
