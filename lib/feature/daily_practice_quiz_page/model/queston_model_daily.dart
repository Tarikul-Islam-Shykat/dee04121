class QuestonModelDaily {
  final int leftNumber;
  final int rightNumber;
  final String operation;
  final List<int> options;
  final int correctAnswer;

  QuestonModelDaily({
    required this.leftNumber,
    required this.rightNumber,
    required this.operation,
    required this.options,
    required this.correctAnswer,
  });

  factory QuestonModelDaily.fromJson(Map<String, dynamic> json) {
    return QuestonModelDaily(
      leftNumber: json['leftNumber'],
      rightNumber: json['rightNumber'],
      operation: json['operation'],
      options: List<int>.from(json['options']),
      correctAnswer: json['correctAnswer'],
    );
  }
}
