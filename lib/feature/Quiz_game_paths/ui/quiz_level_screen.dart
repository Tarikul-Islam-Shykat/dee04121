import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prettyrini/core/const/app_colors.dart';
import 'package:prettyrini/feature/Quiz_game_paths/controller/quiz_level_controller.dart';
import 'package:prettyrini/feature/Quiz_game_paths/model/quiz_level_model.dart';

class QuizLevelScreen extends StatelessWidget {
  const QuizLevelScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final QuizLevelController controller = Get.put(QuizLevelController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/bg.png"), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            }

            return RefreshIndicator(
              onRefresh: controller.refreshData,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(
                        children: [
                          Text(
                            "Math Mission", // Your heading text
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  offset: const Offset(2, 2),
                                  blurRadius: 4,
                                  //  color: Colors.black.withOpacity(0.7),
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 10),
                          Container(
                            width: 60,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final level = controller.quizLevels[index];
                          final isLeftSide = index % 2 == 0;
                          final isLastItem =
                              index == controller.quizLevels.length - 1;

                          return _buildLevelItem(
                            level: level,
                            isLeftSide: isLeftSide,
                            showPath: !isLastItem,
                            onTap: () => controller.onLevelTap(level),
                          );
                        },
                        childCount: controller.quizLevels.length,
                      ),
                    ),
                  ),
                  // Add extra space at bottom
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 100),
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildLevelItem({
    required QuizLevel level,
    required bool isLeftSide,
    required bool showPath,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          if (showPath) _buildDottedPath(isLeftSide),
          Positioned(
            left: isLeftSide ? 1 : null,
            right: isLeftSide ? null : 1,
            top: 0,
            child: GestureDetector(
              onTap: onTap,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    width: 150.w,
                    height: 150.h,
                    child: Image.asset(
                      level.imageAsset,
                      fit: BoxFit.contain,
                      color: level.isUnlocked ? null : Colors.grey,
                      // colorBlendMode:
                      //     level.isUnlocked ? null : BlendMode.saturation,
                    ),
                  ),

                  // Status indicator (top right of character)
                  // if (level.isCompleted)
                  //   Positioned(
                  //     top: 5,
                  //     right: 5,
                  //     child: Container(
                  //       width: 25,
                  //       height: 25,
                  //       decoration: const BoxDecoration(
                  //         color: Colors.green,
                  //         shape: BoxShape.circle,
                  //       ),
                  //       child: const Icon(
                  //         Icons.check,
                  //         color: Colors.white,
                  //         size: 16,
                  //       ),
                  //     ),
                  //   ),
                  if (!level.isUnlocked)
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: const BoxDecoration(
                          color: Colors.grey,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),

                  // Level title positioned over the character (slightly in the middle)
                  Positioned(
                    bottom: 10,
                    child: Container(
                      width: 170,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Stack(
                        children: [
                          // Border (stroke) text
                          Text(
                            _formatLevelTitle(level.title),
                            style: GoogleFonts.rubik(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                              height: 1.1,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 12
                                ..color = Colors.black,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          // Main text with fill color
                          Text(
                            _formatLevelTitle(level.title),
                            style: GoogleFonts.rubik(
                              color: AppColors.txt,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.3,
                              height: 1.1,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatLevelTitle(String title) {
    // Split title into words and format for better display
    List<String> words = title.split(' ');
    if (words.length <= 2) {
      return title.toUpperCase();
    }

    // For titles with more than 2 words, put each word on new line
    return words.map((word) => word.toUpperCase()).join('\n');
  }

  Widget _buildDottedPath(bool isLeftSide) {
    return Positioned(
      left: 0,
      right: 0,
      top: 130, // Start from bottom of current avatar
      child: CustomPaint(
        painter: ZigzagDottedPathPainter(isLeftSide: isLeftSide),
        size: Size(MediaQuery.of(Get.context!).size.width, 80),
      ),
    );
  }
}

class ZigzagDottedPathPainter extends CustomPainter {
  final bool isLeftSide;

  ZigzagDottedPathPainter({required this.isLeftSide});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round; // Added rounded caps for smoother dots

    const dashWidth = 15.0; // Made longer dashes
    const dashSpace = 12.0; // Increased space between dashes

    // Calculate avatar positions based on original positioning
    final leftAvatarX = 1 + 75; // left position + half avatar width (150/2)
    final rightAvatarX =
        size.width - 1 - 75; // right position + half avatar width

    // Create path from current avatar center to next avatar center
    final path = Path();

    if (isLeftSide) {
      // From left avatar center to right avatar center - straighter diagonal
      path.moveTo(leftAvatarX.toDouble(), 0);
      path.lineTo(rightAvatarX, size.height);
    } else {
      // From right avatar center to left avatar center - straighter diagonal
      path.moveTo(rightAvatarX, 0);
      path.lineTo(leftAvatarX.toDouble(), size.height);
    }

    // Draw dashed line along the path
    final pathMetrics = path.computeMetrics();
    for (final pathMetric in pathMetrics) {
      double distance = 0;
      while (distance < pathMetric.length) {
        final extractPath =
            pathMetric.extractPath(distance, distance + dashWidth);
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
