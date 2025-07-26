class QuizLevel {
  final int id;
  final String title;
  final String imageAsset;
  final bool isCompleted;
  final bool isUnlocked;

  QuizLevel({
    required this.id,
    required this.title,
    required this.imageAsset,
    this.isCompleted = false,
    this.isUnlocked = true,
  });

  factory QuizLevel.fromJson(Map<String, dynamic> json) {
    return QuizLevel(
      id: json['id'],
      title: json['title'],
      imageAsset: json['imageAsset'],
      isCompleted: json['isCompleted'] ?? false,
      isUnlocked: json['isUnlocked'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imageAsset': imageAsset,
      'isCompleted': isCompleted,
      'isUnlocked': isUnlocked,
    };
  }
}
