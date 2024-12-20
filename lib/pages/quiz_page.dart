// pages/quiz_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/quiz_provider.dart';
import 'result_page.dart';

class QuizPage extends StatelessWidget {
  const QuizPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Football Quiz'),
        backgroundColor: Colors.blue[300],
      ),
      body: Consumer<QuizProvider>(
        builder: (context, quizProvider, child) {
          if (quizProvider.isQuizFinished()) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ResultPage(
                    score: quizProvider.score,
                    total: quizProvider.questions.length,
                  ),
                ),
              );
            });
            return const SizedBox();
          }
          return SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  _buildImageContainer(quizProvider),
                  const SizedBox(height: 20),
                  _buildQuestionContainer(quizProvider),
                  const SizedBox(height: 30),
                  _buildAnswerButtons(quizProvider),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildImageContainer(QuizProvider quizProvider) {
    return Container(
      height: 300,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          quizProvider.currentQuestion.imagePath,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget _buildQuestionContainer(QuizProvider quizProvider) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Text(
            "Question ${quizProvider.currentQuestionIndex + 1}/${quizProvider.questions.length}",
            style: TextStyle(
              color: Colors.blue[300],
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            quizProvider.currentQuestion.questionText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildAnswerButtons(QuizProvider quizProvider) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildAnswerButton(quizProvider, true, 'VRAI'),
        _buildAnswerButton(quizProvider, false, 'FAUX'),
      ],
    );
  }

  Widget _buildAnswerButton(
      QuizProvider quizProvider, bool isTrue, String text) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue[100],
        foregroundColor: Colors.blue[900],
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      onPressed: () => quizProvider.answerQuestion(isTrue),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
