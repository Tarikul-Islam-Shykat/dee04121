// lib/feature/bottom_nav/widget/custom_bottom_nav.dart (Responsive Version)
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../controller/bottom_nav_controller.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = constraints.maxWidth;
        final isTablet = screenWidth > 600;
        final isLargeScreen = screenWidth > 900;

        // Responsive padding and spacing
        final horizontalPadding =
            isLargeScreen ? 30.0 : (isTablet ? 20.0 : 15.0);
        final verticalPadding = isTablet ? 16.0 : 12.0;
        final fabSpacing = isLargeScreen ? 120.0 : (isTablet ? 100.0 : 80.0);
        final borderRadius = isTablet ? 35.0 : 30.0;

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: isTablet ? 20 : 15,
                offset: const Offset(0, -8),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding, vertical: verticalPadding),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left side nav items
                      Expanded(
                        flex: isLargeScreen ? 2 : 1,
                        child: _buildNavSection(
                          controller: controller,
                          isLeftSection: true,
                          isTablet: isTablet,
                          isLargeScreen: isLargeScreen,
                        ),
                      ),

                      // Center FAB Space with responsive width
                      SizedBox(width: fabSpacing),

                      // Right side nav items
                      Expanded(
                        flex: isLargeScreen ? 2 : 1,
                        child: _buildNavSection(
                          controller: controller,
                          isLeftSection: false,
                          isTablet: isTablet,
                          isLargeScreen: isLargeScreen,
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavSection({
    required BottomNavController controller,
    required bool isLeftSection,
    required bool isTablet,
    required bool isLargeScreen,
  }) {
    // Responsive sizing
    final iconSize = isLargeScreen ? 28.0 : (isTablet ? 26.0 : 24.0);
    final horizontalPadding = isLargeScreen ? 24.0 : (isTablet ? 22.0 : 20.0);
    final verticalPadding = isTablet ? 14.0 : 12.0;
    final gap = isTablet ? 10.0 : 8.0;
    final fontSize = isTablet ? 14.0 : 12.0;

    if (isLeftSection) {
      return GNav(
        selectedIndex: controller.currentIndex.value > 1
            ? controller.currentIndex.value - 1
            : controller.currentIndex.value,
        onTabChange: (index) {
          HapticFeedback.lightImpact();
          if (index >= 1) {
            controller.changeTabIndex(index + 1); // Skip FAB index
          } else {
            controller.changeTabIndex(index);
          }
        },
        gap: gap,
        activeColor: const Color(0xFF00C896),
        iconSize: iconSize,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: const Color(0xFF00C896).withOpacity(0.1),
        color: Colors.grey.shade400,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          GButton(
            icon: Icons.home_outlined,
            text: isTablet ? 'Home' : (isLargeScreen ? 'Home' : ''),
          ),
          GButton(
            icon: Icons.psychology_outlined,
            text: isTablet ? 'Practice' : (isLargeScreen ? 'Practice' : ''),
          ),
        ],
      );
    } else {
      return GNav(
        selectedIndex: controller.currentIndex.value > 2
            ? controller.currentIndex.value - 3
            : -1,
        onTabChange: (index) {
          HapticFeedback.lightImpact();
          controller
              .changeTabIndex(index + 3); // Progress Report = 3, Profile = 4
        },
        gap: gap,
        activeColor: const Color(0xFF00C896),
        iconSize: iconSize,
        padding: EdgeInsets.symmetric(
            horizontal: horizontalPadding, vertical: verticalPadding),
        duration: const Duration(milliseconds: 400),
        tabBackgroundColor: const Color(0xFF00C896).withOpacity(0.1),
        color: Colors.grey.shade400,
        textStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w600,
        ),
        tabs: [
          GButton(
            icon: Icons.bar_chart_outlined,
            text: isTablet ? 'Progress' : (isLargeScreen ? 'Progress' : ''),
          ),
          GButton(
            icon: Icons.person_outline,
            text: isTablet ? 'Profile' : (isLargeScreen ? 'Profile' : ''),
          ),
        ],
      );
    }
  }
}

// Responsive AnimatedCenterFAB
class AnimatedCenterFAB extends StatelessWidget {
  const AnimatedCenterFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth > 600;
        final isLargeScreen = screenWidth > 900;

        // Responsive FAB sizing
        final fabSize = isLargeScreen ? 75.0 : (isTablet ? 70.0 : 65.0);
        final iconSize = isLargeScreen ? 32.0 : (isTablet ? 30.0 : 28.0);
        final shadowBlur = isTablet ? 25.0 : 20.0;
        final shadowOffset = isTablet ? 10.0 : 8.0;

        return AnimatedBuilder(
          animation: controller.fabAnimationController,
          builder: (context, child) {
            return Transform.scale(
              scale: controller.fabScaleAnimation.value,
              child: Obx(() => Container(
                    width: fabSize,
                    height: fabSize,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: controller.currentIndex.value == 2
                            ? [const Color(0xFF00C896), const Color(0xFF0EA5E9)]
                            : [
                                const Color(0xFF0EA5E9),
                                const Color(0xFF3B82F6)
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0EA5E9).withOpacity(0.3),
                          blurRadius: shadowBlur,
                          offset: Offset(0, shadowOffset),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(fabSize / 2),
                        onTap: () {
                          HapticFeedback.mediumImpact();
                          controller.onFabPressed();
                        },
                        child: Container(
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Icon(
                            controller.currentIndex.value == 2
                                ? Icons.leaderboard
                                : Icons.currency_yen,
                            color: Colors.white,
                            size: iconSize,
                          )
                              .animate(
                                  target: controller.currentIndex.value == 2
                                      ? 1
                                      : 0)
                              .rotate(
                                duration: 300.ms,
                                curve: Curves.easeInOut,
                                begin: 0,
                                end: 0.5,
                              )
                              .then()
                              .shimmer(
                                duration: 1000.ms,
                                color: Colors.white.withOpacity(0.6),
                              ),
                        ),
                      ),
                    ),
                  )),
            ).animate().scale(
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                  begin: const Offset(0.8, 0.8),
                  end: const Offset(1.0, 1.0),
                );
          },
        );
      },
    );
  }
}

// Responsive SimpleFAB (Alternative)
class SimpleFAB extends StatelessWidget {
  const SimpleFAB({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.find();

    return LayoutBuilder(
      builder: (context, constraints) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isTablet = screenWidth > 600;
        final isLargeScreen = screenWidth > 900;

        // Responsive sizing
        final fabSize = isLargeScreen ? 75.0 : (isTablet ? 70.0 : 65.0);
        final iconSize = isLargeScreen ? 32.0 : (isTablet ? 30.0 : 28.0);
        final shadowBlur = isTablet ? 25.0 : 20.0;
        final shadowOffset = isTablet ? 10.0 : 8.0;

        return Obx(() => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: fabSize,
              height: fabSize,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: controller.currentIndex.value == 2
                      ? [const Color(0xFF00C896), const Color(0xFF0EA5E9)]
                      : [const Color(0xFF0EA5E9), const Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF0EA5E9).withOpacity(0.3),
                    blurRadius: shadowBlur,
                    offset: Offset(0, shadowOffset),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(fabSize / 2),
                  onTap: () {
                    HapticFeedback.mediumImpact();
                    controller.onFabPressed();
                  },
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      controller.currentIndex.value == 2
                          ? Icons.leaderboard
                          : Icons.currency_yen,
                      key: ValueKey(controller.currentIndex.value == 2),
                      color: Colors.white,
                      size: iconSize,
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}

// Optional: Responsive Bottom Navigation Wrapper
class ResponsiveBottomNavWrapper extends StatelessWidget {
  final Widget child;

  const ResponsiveBottomNavWrapper({Key? key, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final screenWidth = MediaQuery.of(context).size.width;
        final isLandscape = orientation == Orientation.landscape;
        final showBottomNav = !isLandscape || screenWidth > 800;

        if (!showBottomNav) {
          // For landscape on smaller screens, you might want to hide the bottom nav
          // or show a different navigation pattern
          return const SizedBox.shrink();
        }

        return child;
      },
    );
  }
}
