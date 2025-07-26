// models/account_model.dart
import 'package:flutter/material.dart';

class AccountModel {
  final String name;
  final String avatarPath;
  final int rank;
  final int level;
  final int coins;
  final int currentXp;
  final int maxXp;
  final String nextLevel;

  AccountModel({
    required this.name,
    required this.avatarPath,
    required this.rank,
    required this.level,
    required this.coins,
    required this.currentXp,
    required this.maxXp,
    required this.nextLevel,
  });
}

class StatsCardModel {
  final String title;
  final String value;
  final String gradient;
  final IconData icon;

  StatsCardModel({
    required this.title,
    required this.value,
    required this.gradient,
    required this.icon,
  });
}
