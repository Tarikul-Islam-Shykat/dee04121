import 'package:flutter/material.dart';
import 'package:prettyrini/feature/progress_report/controller/progress_report_controller.dart';

class ProgressCard extends StatelessWidget {
  final ProgressData progressData;
  final Color cardColor;

  const ProgressCard({
    Key? key,
    required this.progressData,
    required this.cardColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: cardColor.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(
            progressData.title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),

          // Progress Bar
          _buildProgressBar(),

          const SizedBox(height: 12),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLegendItem(
                color: Colors.green,
                label: '${progressData.correct} Correct',
              ),
              _buildLegendItem(
                color: Colors.orange,
                label: '${progressData.skipped} Skipped',
              ),
              _buildLegendItem(
                color: Colors.red,
                label: '${progressData.incorrect} Incorrect',
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Total questions
          Center(
            child: Text(
              'Total: ${progressData.total} questions',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    // Create list of progress items with their values and colors
    List<ProgressItem> items = [
      ProgressItem(
          value: progressData.correct, color: Colors.green, label: 'Correct'),
      ProgressItem(
          value: progressData.skipped, color: Colors.orange, label: 'Skipped'),
      ProgressItem(
          value: progressData.incorrect, color: Colors.red, label: 'Incorrect'),
    ];

    // Sort by value in descending order (highest to lowest)
    items.sort((a, b) => b.value.compareTo(a.value));

    // Calculate total width needed (500+ minimum)
    int totalQuestions =
        progressData.correct + progressData.skipped + progressData.incorrect;
    int baseWidth = totalQuestions < 500 ? 500 : totalQuestions;

    return Container(
      height: 12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey[200],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Row(
          children: items.asMap().entries.map((entry) {
            int index = entry.key;
            ProgressItem item = entry.value;

            if (item.value == 0) return const SizedBox.shrink();

            BorderRadius borderRadius;
            if (index == 0 && items.length == 1) {
              borderRadius = BorderRadius.circular(6);
            } else if (index == 0) {
              borderRadius = const BorderRadius.only(
                topLeft: Radius.circular(6),
                bottomLeft: Radius.circular(6),
              );
            } else if (index == items.length - 1) {
              borderRadius = const BorderRadius.only(
                topRight: Radius.circular(6),
                bottomRight: Radius.circular(6),
              );
            } else {
              borderRadius = BorderRadius.zero;
            }

            return Expanded(
              flex: item.value,
              child: Container(
                decoration: BoxDecoration(
                  color: item.color,
                  borderRadius: borderRadius,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildLegendItem({
    required Color color,
    required String label,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class ProgressItem {
  final int value;
  final Color color;
  final String label;

  ProgressItem({
    required this.value,
    required this.color,
    required this.label,
  });
}
