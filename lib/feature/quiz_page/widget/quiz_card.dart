import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/feature/quiz_page/controller/quiz_controller.dart';
import 'package:prettyrini/feature/quiz_page/model/quiz_model.dart';

class OptionCard extends StatelessWidget {
  final OptionModel option;
  final int index;
  final QuizController controller;

  const OptionCard({
    Key? key,
    required this.option,
    required this.index,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelected = controller.selectedAnswerIndex == index;
      final showAnswer = controller.showAnswer;
      final isCorrect = option.isCorrect;

      Color backgroundColor;
      Color borderColor;
      Color textColor;
      Widget? trailingIcon;

      if (!showAnswer) {
        if (isSelected) {
          backgroundColor = Colors.transparent;
          borderColor = const Color(0xFF0087B7);
          textColor = Colors.black87;
        } else {
          backgroundColor = Colors.white;
          borderColor = Colors.grey.shade300;
          textColor = Colors.black87;
        }
        trailingIcon = Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey.shade400, width: 2),
            color: isSelected ? const Color(0xFF3ADEFF) : Colors.transparent,
          ),
          child: isSelected
              ? const Icon(Icons.check, color: Colors.white, size: 16)
              : null,
        );
      } else {
        if (isCorrect) {
          backgroundColor = Colors.green;
          borderColor = Colors.green.shade700;
          textColor = Colors.white;
          trailingIcon = const Icon(Icons.check_circle, color: Colors.white);
        } else if (isSelected && !isCorrect) {
          backgroundColor = Colors.red;
          borderColor = Colors.red.shade700;
          textColor = Colors.white;
          trailingIcon = const Icon(Icons.cancel, color: Colors.white);
        } else {
          backgroundColor = Colors.grey.shade300;
          borderColor = Colors.grey.shade400;
          textColor = Colors.grey.shade600;
          trailingIcon = Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400, width: 2),
            ),
          );
        }
      }

      return GestureDetector(
        onTap: () => controller.selectAnswer(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: borderColor, width: 2),
            gradient: isSelected && !showAnswer
                ? const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF3ADEFF), Color(0xFF0087B7)],
                  )
                : null,
            boxShadow: [
              if (isSelected && !showAnswer)
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                option.label,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isSelected && !showAnswer
                      ? Colors.white
                      : Colors.blue.shade600,
                ),
              ),
              Text(
                option.value,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              trailingIcon!,
            ],
          ),
        ),
      );
    });
  }
}
