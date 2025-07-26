import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:prettyrini/feature/account/ui/account_ui.dart';
import 'package:prettyrini/feature/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:prettyrini/feature/bottom_nav/widget/custom_bottom_nav.dart';
import 'package:prettyrini/feature/daily_practice/ui/daily_ui_page.dart';
import 'package:prettyrini/feature/home_page/ui/home_page.dart';
import 'package:prettyrini/feature/leader_board/ui/leader_board_ui.dart';
import 'package:prettyrini/feature/progress_report/ui/progress_report_page.dart';

class BottomNavScreen extends StatelessWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BottomNavController controller = Get.put(BottomNavController());

    final List<Widget> screens = [
      const HomePage(), // Index 0
      const DailyPracticesPage(), // Index 1
      const LeaderboardScreen(), // Index 2 (FAB target)
      ProgressReportPage(), // Index 3
      const AccountPage(), // Index 4
    ];

    return Scaffold(
      extendBody: true,
      body: Obx(() => AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeInOut,
            switchOutCurve: Curves.easeInOut,
            child: IndexedStack(
              key: ValueKey(controller.currentIndex.value),
              index: controller.currentIndex.value,
              children: screens,
            ),
          )),
      floatingActionButton: const AnimatedCenterFAB().animate().slideY(
            duration: 800.ms,
            begin: 2,
            curve: Curves.elasticOut,
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const CustomBottomNav().animate().slideY(
            duration: 600.ms,
            begin: 1,
            curve: Curves.easeOutCubic,
          ),
    );
  }
}
