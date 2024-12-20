// providers/quiz_provider.dart
import 'package:flutter/foundation.dart';
import '../models/question.dart';

class QuizProvider with ChangeNotifier {
  final List<Question> _questions = [
    Question(
      questionText: "Kylian Mbappé a-t-il remporté la Coupe du Monde 2018 ?",
      isCorrect: true,
      imagePath: "assets/quiz1.jpg",
    ),
    Question(
      questionText:
          "Lionel Messi a-t-il gagné la Ligue des Champions avec le PSG ?",
      isCorrect: false,
      imagePath: "assets/quiz2.jpg",
    ),
    Question(
      questionText:
          "Le Real Madrid est-il le club le plus titré en Ligue des Champions ?",
      isCorrect: true,
      imagePath: "assets/quiz3.jpg",
    ),
  ];

  int _currentQuestionIndex = 0;
  int _score = 0;

  List<Question> get questions => _questions;
  int get currentQuestionIndex => _currentQuestionIndex;
  int get score => _score;
  Question get currentQuestion => _questions[_currentQuestionIndex];

  void answerQuestion(bool userChoice) {
    if (currentQuestion.isCorrect == userChoice) {
      _score++;
    }
    if (_currentQuestionIndex < _questions.length - 1) {
      _currentQuestionIndex++;
      notifyListeners();
    } else {
      _currentQuestionIndex++;
      notifyListeners();
    }
  }

  bool isQuizFinished() => _currentQuestionIndex >= _questions.length;

  void resetQuiz() {
    _currentQuestionIndex = 0;
    _score = 0;
    notifyListeners();
  }
}
