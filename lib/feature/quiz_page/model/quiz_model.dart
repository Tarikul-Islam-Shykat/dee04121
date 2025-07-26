class QuestionModel {
  final int id;
  final String question;
  final List<OptionModel> options;

  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
  });
}

class OptionModel {
  final String label;
  final String value;
  final bool isCorrect;

  OptionModel({
    required this.label,
    required this.value,
    required this.isCorrect,
  });
}
