import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/daily_practice_quiz_page/controller/daily_quiz_controller.dart';
import 'package:prettyrini/feature/daily_practice_quiz_page/widget/flower_widget.dart';
import 'package:prettyrini/feature/daily_practice_quiz_page/widget/option_tile_widget.dart';

class DailyQuizScreen extends StatelessWidget {
  final DailyQuizController controller = Get.put(DailyQuizController());

  DailyQuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          child: Obx(() {
            final question = controller.currentQuestion.value;
            if (question == null) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Color(0xFF3ADEFF), Color(0xFF0087B7)],
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlowerNumberWidget(number: question.leftNumber),
                              const SizedBox(width: 20),
                              // Your plus icon image
                              Image.asset(
                                ImagePath.add_icon,
                                width: 40,
                                height: 40,
                                fit: BoxFit.contain,
                              ),
                              const SizedBox(width: 20),
                              FlowerNumberWidget(number: question.rightNumber),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        ...question.options.asMap().entries.map((entry) {
                          final index = entry.key;
                          final option = entry.value;
                          final labels = ['A', 'B', 'C', 'D'];
                          final isSelected =
                              controller.selectedAnswer.value == option;
                          final isCorrect = controller.isCorrectAnswer(option);

                          return OptionTileWidget(
                            label: labels[index],
                            value: option,
                            isSelected: isSelected,
                            isCorrect: isCorrect,
                            showResult: controller.isAnswered.value,
                            onTap: () => controller.selectAnswer(option),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                // Options Section
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        const Spacer(),
                        // Next Button
                        if (controller.isAnswered.value)
                          Container(
                            width: double.infinity,
                            margin: const EdgeInsets.all(20),
                            child: ElevatedButton(
                              onPressed: controller.nextQuestion,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF4CAF50),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Next',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
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
            );
          }),
        ),
      ),
    );
  }
}
