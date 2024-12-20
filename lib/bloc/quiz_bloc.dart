import 'package:flutter_bloc/flutter_bloc.dart';
import 'quiz_event.dart';
import 'quiz_state.dart';
import '../models/question.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
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

  QuizBloc()
      : super(
          QuizInProgress(
            questions: [
              Question(
                questionText:
                    "Kylian Mbappé a-t-il remporté la Coupe du Monde 2018 ?",
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
            ],
            currentQuestionIndex: 0,
            score: 0,
          ),
        ) {
    on<AnswerQuestion>(_onAnswerQuestion);
    on<ResetQuiz>(_onResetQuiz);
  }

  void _onAnswerQuestion(AnswerQuestion event, Emitter<QuizState> emit) {
    if (state is QuizInProgress) {
      final currentState = state as QuizInProgress;

      final isCorrect =
          currentState.questions[currentState.currentQuestionIndex].isCorrect;
      final updatedScore = event.userChoice == isCorrect
          ? currentState.score + 1
          : currentState.score;

      final nextIndex = currentState.currentQuestionIndex + 1;
      if (nextIndex < currentState.questions.length) {
        emit(QuizInProgress(
          questions: currentState.questions,
          currentQuestionIndex: nextIndex,
          score: updatedScore,
        ));
      } else {
        emit(QuizFinished(
          score: updatedScore,
          totalQuestions: currentState.questions.length,
        ));
      }
    }
  }

  void _onResetQuiz(ResetQuiz event, Emitter<QuizState> emit) {
    emit(QuizInProgress(
      questions: _questions,
      currentQuestionIndex: 0,
      score: 0,
    ));
  }
}
