import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prettyrini/core/const/image_path.dart';
import 'package:prettyrini/feature/quiz_page/controller/quiz_controller.dart';
import 'package:prettyrini/feature/quiz_page/widget/quiz_card.dart';

class QuizScreen extends StatelessWidget {
  final QuizController controller = Get.put(QuizController());

  QuizScreen({Key? key}) : super(key: key);

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
        child: Obx(() {
          if (controller.quizCompleted) {
            return _buildCompletionScreen();
          }
          return _buildQuizScreen();
        }),
      ),
    );
  }

  Widget _buildQuizScreen() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    _buildHeader(),
                    _buildProgressBar(),
                    const SizedBox(height: 20),
                    _buildQuestionCard(),
                    const SizedBox(height: 20),
                    SizedBox(height: 350, child: _buildOptionsSection()),
                    //  _buildNextButton(),
                  ],
                ),
              ),
            ),
            Spacer(),
            _buildNextButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Obx(() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${controller.currentQuestionIndex + 1} of ${controller.totalQuestions}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(Icons.close, color: Colors.grey),
            ),
          ],
        ));
  }

  Widget _buildProgressBar() {
    return Obx(() => Container(
          width: double.infinity,
          height: 15,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(4),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: controller.progress,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF1DE5B1), Color(0xFF1BA570)],
                ),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ),
        ));
  }

  Widget _buildQuestionCard() {
    return Obx(() => Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF3ADEFF), Color(0xFF0087B7)],
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Text(
            controller.currentQuestion.question,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white,
              height: 1.4,
            ),
          ),
        ));
  }

  Widget _buildOptionsSection() {
    return Obx(() => ListView.builder(
          itemCount: controller.currentQuestion.options.length,
          itemBuilder: (context, index) {
            return OptionCard(
              option: controller.currentQuestion.options[index],
              index: index,
              controller: controller,
            );
          },
        ));
  }

  Widget _buildNextButton() {
    return Obx(() => Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1DE5B1), Color(0xFF1BA570)],
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0xFF008150),
                offset: Offset(0, 4),
                blurRadius: 0,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: controller.isNextButtonEnabled
                ? () => controller.handleNext()
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Text(
              controller.nextButtonText,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ));
  }

  Widget _buildCompletionScreen() {
    return Obx(() => Center(
          child: Container(
            margin: const EdgeInsets.all(24),
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🎉', style: TextStyle(fontSize: 64)),
                const SizedBox(height: 16),
                const Text(
                  'Quiz Complete!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                    children: [
                      const TextSpan(text: 'You scored '),
                      TextSpan(
                        text: '${controller.score}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      const TextSpan(text: ' out of '),
                      TextSpan(
                        text: '${controller.totalQuestions}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  controller.getScoreMessage(),
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox(height: 32),
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFF1DE5B1), Color(0xFF1BA570)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xFF008150),
                        offset: Offset(0, 4),
                        blurRadius: 0,
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () => controller.resetQuiz(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Play Again',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
