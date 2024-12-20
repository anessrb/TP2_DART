import 'package:equatable/equatable.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object?> get props => [];
}

class AnswerQuestion extends QuizEvent {
  final bool userChoice;

  const AnswerQuestion(this.userChoice);

  @override
  List<Object?> get props => [userChoice];
}

class ResetQuiz extends QuizEvent {}
