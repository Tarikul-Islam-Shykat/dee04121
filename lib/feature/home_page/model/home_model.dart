// models/challenge_model.dart
class HomeModel {
  final String title;
  final String subtitle;
  final int duration;
  final int questions;
  final String difficulty;

  HomeModel({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.questions,
    required this.difficulty,
  });
}

class UserModel {
  final String name;
  final int coins;
  final String avatarPath;

  UserModel({
    required this.name,
    required this.coins,
    required this.avatarPath,
  });
}
