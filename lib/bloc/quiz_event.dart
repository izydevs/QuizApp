part of 'quiz_bloc.dart';

abstract class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class NavigateToQuestionPage extends QuizEvent{
  NavigateToQuestionPage();
  @override
  List<Object> get props => [];
}

class NavigateToReadyPage extends QuizEvent{
  NavigateToReadyPage();
  @override
  List<Object> get props => [];
}
class SubmitAnswer extends QuizEvent{
  final QuizModel quiz;
  SubmitAnswer(this.quiz);
  @override
  List<Object> get props => [quiz];
}
