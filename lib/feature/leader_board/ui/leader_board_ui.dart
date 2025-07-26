import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/leader_board/controller/leader_board_controller.dart';
import 'package:prettyrini/feature/leader_board/model/leader_board_user.dart';

class LeaderboardScreen extends StatelessWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LeaderboardController controller = Get.put(LeaderboardController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(ImagePath.bg), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 24.sp,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'Leaderboard',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 40.w), // Balance the back button
                  ],
                ),
              ),

              // Top 3 Podium
              Obx(() => _buildTopThreePodium(controller)),

              // Leaderboard List
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.r),
                      topRight: Radius.circular(25.r),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      Expanded(
                        child: Obx(() => _buildLeaderboardList(controller)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopThreePodium(LeaderboardController controller) {
    return Container(
      height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // 2nd Place
          _buildPodiumUser(controller.topThreeUsers[0]),
          // 1st Place (Winner - Higher position)
          Transform.translate(
            offset: Offset(0, -20.h),
            child: _buildPodiumUser(controller.topThreeUsers[1]),
          ),
          // 3rd Place
          _buildPodiumUser(controller.topThreeUsers[2]),
        ],
      ),
    );
  }

  Widget _buildPodiumUser(LeaderboardUser user) {
    final colors = _getPodiumColors(user.rank);
    final size = user.rank == 1 ? 100.0.w : 80.0.w;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Crown for winner
        if (user.rank == 1)
          Container(
            margin: EdgeInsets.only(bottom: 8.h),
            child: Icon(
              Icons.emoji_events,
              color: Colors.yellow,
              size: 30.sp,
            ),
          ),

        // Avatar with gradient border
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: colors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: colors[0].withOpacity(0.3),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Container(
            margin: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(user.avatarPath),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        // Rank badge
        Container(
          margin: EdgeInsets.only(top: 8.h, bottom: 4.h),
          width: 24.w,
          height: 24.w,
          decoration: BoxDecoration(
            color: colors[0],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              '#${user.rank}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        // Name
        Text(
          user.name,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),

        // Level and coins
        Text(
          'Level: ${user.level} \n Coin: ${user.coins}',
          style: TextStyle(
            color: Colors.white,
            fontSize: 10.sp,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLeaderboardList(LeaderboardController controller) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: controller.otherUsers.length + 1, // +1 for current user
      itemBuilder: (context, index) {
        if (index < controller.otherUsers.length) {
          return _buildLeaderboardItem(controller.otherUsers[index]);
        } else {
          // Current user at the bottom
          return _buildLeaderboardItem(controller.currentUser.value,
              isCurrentUser: true);
        }
      },
    );
  }

  Widget _buildLeaderboardItem(LeaderboardUser user,
      {bool isCurrentUser = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isCurrentUser
            ? Colors.orange.withOpacity(0.1)
            : Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: isCurrentUser
            ? Border.all(color: Colors.orange.withOpacity(0.3), width: 1)
            : null,
      ),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(user.avatarPath),
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(width: 12.w),

          // User info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: isCurrentUser ? Colors.orange : Colors.black,
                  ),
                ),
                Text(
                  'Level: ${user.level} | Coin: ${user.coins}',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),

          // Rank and arrow
          Column(
            children: [
              Text(
                '#${user.rank}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isCurrentUser ? Colors.orange : Colors.black,
                ),
              ),
              Icon(
                user.isUp ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                color: user.isUp ? Colors.green : Colors.red,
                size: 20.sp,
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<Color> _getPodiumColors(int rank) {
    switch (rank) {
      case 1:
        return [Color(0xFFFFD700), Color(0xFFFFA500)]; // Gold gradient
      case 2:
        return [Color(0xFFFF69B4), Color(0xFFFF1493)]; // Pink gradient
      case 3:
        return [Color(0xFF00BFFF), Color(0xFF1E90FF)]; // Blue gradient
      default:
        return [Color(0xFFFFD700), Color(0xFFFFA500)];
    }
  }
}
