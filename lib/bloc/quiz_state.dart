part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  final String quizType;
  final QuizStatus quizStatus;
  final int quizNo;
  final List<QuizModel> quizzes;
  final Map<String, double> quizResult;

  QuizState({this.quizType, this.quizStatus, this.quizNo, this.quizzes, this.quizResult});

  QuizState copyWith(
      {String quizType,
      QuizStatus quizStatus,
      int quizNo,
      List<QuizModel> quizzes,
      Map<String, double> quizResult}) {
    return QuizState(
        quizType: quizType ?? this.quizType,
        quizStatus: quizStatus ?? this.quizStatus,
        quizNo: quizNo ?? this.quizNo,
        quizzes: quizzes ?? this.quizzes,
        quizResult: quizResult ?? this.quizResult);
  }

  @override
  List<Object> get props => [quizType, quizStatus, quizNo, quizzes,quizResult];
}
