import 'package:flutter/material.dart';

class OptionTileWidget extends StatelessWidget {
  final String label;
  final int value;
  final bool isSelected;
  final bool isCorrect;
  final bool showResult;
  final VoidCallback onTap;

  const OptionTileWidget({
    Key? key,
    required this.label,
    required this.value,
    required this.isSelected,
    required this.isCorrect,
    required this.showResult,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color backgroundColor = Colors.white;
    Color borderColor = Colors.grey.shade300;

    if (showResult) {
      if (isSelected && isCorrect) {
        backgroundColor = const Color(0xFF4CAF50);
        borderColor = const Color(0xFF4CAF50);
      } else if (isSelected && !isCorrect) {
        backgroundColor = Colors.red.shade100;
        borderColor = Colors.red;
      } else if (isCorrect) {
        backgroundColor = const Color(0xFF4CAF50);
        borderColor = const Color(0xFF4CAF50);
      }
    } else if (isSelected) {
      backgroundColor = const Color(0xFF03A9F4);
      borderColor = const Color(0xFF03A9F4);
    }

    return GestureDetector(
      onTap: showResult ? null : onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 2),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.white : Colors.transparent,
                border: Border.all(
                  color: isSelected ? backgroundColor : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  label,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: isSelected ? backgroundColor : Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            Text(
              value.toString(),
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
            const Spacer(),
            if (showResult && isCorrect)
              const Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
