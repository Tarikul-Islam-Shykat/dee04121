class LeaderboardUser {
  final String name;
  final int level;
  final int coins;
  final String avatarPath;
  final int rank;
  final bool isUp; // true for up arrow, false for down arrow

  LeaderboardUser({
    required this.name,
    required this.level,
    required this.coins,
    required this.avatarPath,
    required this.rank,
    required this.isUp,
  });
}
