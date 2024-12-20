import 'package:equatable/equatable.dart';
import '../models/question.dart';

abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizInProgress extends QuizState {
  final List<Question> questions;
  final int currentQuestionIndex;
  final int score;

  const QuizInProgress({
    required this.questions,
    required this.currentQuestionIndex,
    required this.score,
  });

  @override
  List<Object?> get props => [questions, currentQuestionIndex, score];
}

class QuizFinished extends QuizState {
  final int score;
  final int totalQuestions;

  const QuizFinished({
    required this.score,
    required this.totalQuestions,
  });

  @override
  List<Object?> get props => [score, totalQuestions];
}
