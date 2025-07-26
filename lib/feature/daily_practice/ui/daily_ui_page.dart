import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/daily_practice/controller/daily_practice_controller.dart';

class DailyPracticesPage extends StatelessWidget {
  const DailyPracticesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DailyPracticesController>(
      init: DailyPracticesController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(ImagePath.bg),
                fit: BoxFit.cover,
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(),
                  Expanded(
                    child: _buildPracticeCards(controller),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: const Text(
        'Daily Practices',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPracticeCards(DailyPracticesController controller) {
    return Obx(() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListView.separated(
            itemCount: controller.practiceItems.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final item = controller.practiceItems[index];
              return _buildPracticeCard(item, controller);
            },
          ),
        ));
  }

  Widget _buildPracticeCard(
      PracticeItem item, DailyPracticesController controller) {
    return GestureDetector(
      onTap: () => controller.onPracticeCardTap(item),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: item.backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildCardIcon(item),
            const SizedBox(width: 16),
            Expanded(
              child: _buildCardContent(item),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardIcon(PracticeItem item) {
    return Center(
      child: Image.asset(
        item.imagePath,
        width: 65.w,
        height: 65.h,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to icon if image fails to load
          return Icon(
            item.icon,
            size: 35,
            color: _getIconColor(item.practiceType),
          );
        },
      ),
    );
  }

  Widget _buildCardContent(PracticeItem item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          item.description,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black,
            height: 1.3,
          ),
        ),
      ],
    );
  }

  Color _getTextColor(PracticeType type) {
    switch (type) {
      case PracticeType.addition:
      case PracticeType.division:
        return const Color(0xFF2C5F2D);
      case PracticeType.subtraction:
      case PracticeType.multiplication:
        return const Color(0xFF8B4513);
      default:
        return Colors.black87;
    }
  }

  Color _getIconColor(PracticeType type) {
    switch (type) {
      case PracticeType.addition:
        return const Color(0xFF4CAF50);
      case PracticeType.subtraction:
        return const Color(0xFFFF5722);
      case PracticeType.multiplication:
        return const Color(0xFFFF9800);
      case PracticeType.division:
        return const Color(0xFF2196F3);
      default:
        return Colors.grey;
    }
  }
}
