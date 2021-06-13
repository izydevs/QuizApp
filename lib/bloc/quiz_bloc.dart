import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/bloc/quiz_repository.dart';
import 'package:quiz_app/model/quiz_model.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

enum QuizStatus { INITIAL, GET_READY, QUESTION, ANSWER, RESULT }

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final QuizRepository quizRepository;
  final GlobalKey<NavigatorState> navigatorKey;
  Map<String, double> dataMap = {
    "Answered": 0.0,
    "Un-Answered": 0.0,
    "Wrong Answer": 0.0,
  };

  QuizBloc({this.quizRepository, this.navigatorKey})
      : assert(quizRepository != null, navigatorKey != null),
        super(QuizState(quizStatus: QuizStatus.INITIAL, quizNo: 0, quizzes: [],quizResult: {}));

  @override
  void onTransition(Transition<QuizEvent, QuizState> transition) {
    super.onTransition(transition);
  }



  @override
  Stream<QuizState> mapEventToState(QuizEvent event) async* {
    if (event is NavigateToQuestionPage) {
      yield state.copyWith(
          quizStatus: state.quizNo == 10 ? QuizStatus.RESULT : QuizStatus.QUESTION,
          quizNo: state.quizNo + 1);
    }
    if (event is NavigateToReadyPage) {
      yield state.copyWith(
          quizStatus: state.quizNo == 10 ? QuizStatus.RESULT : QuizStatus.GET_READY);
    }
    if (event is SubmitAnswer) {
      state.quizzes.add(event.quiz);
      if (state.quizNo == 10) {
        state.quizzes.forEach((element) {
          if (element.answered.isEmpty) {
            dataMap.forEach((key, value) {
              if (key == 'Un-Answered') dataMap[key] = value + 1;
            });
            // dataMap['Un-Answered'] = dataMap['Un-Answered']++;
          } else {
            if (element.answered == element.answer) {
              dataMap.forEach((key, value) {
                if (key == 'Answered') dataMap[key] = value + 1;
              });
              // dataMap['Answered'] = dataMap['Answered']++;
            } else {
              dataMap.forEach((key, value) {
                if (key == 'Wrong Answer') dataMap[key] = value + 1;
              });
              // dataMap['Wrong Answered'] = dataMap['Wrong Answered']++;
            }
          }
        });
        print('quiz result $dataMap');
        yield state.copyWith(quizStatus: QuizStatus.RESULT,quizResult: dataMap);
      } else {
        yield state.copyWith(quizStatus: QuizStatus.GET_READY);
      }
    }
  }
}
