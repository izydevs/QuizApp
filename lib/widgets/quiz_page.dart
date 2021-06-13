import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz_bloc.dart';
import 'package:quiz_app/bloc/quiz_repository.dart';
import 'package:quiz_app/utils/page_route_builders/fade_route.dart';
import 'package:quiz_app/widgets/get_ready.dart';
import 'package:quiz_app/widgets/question_page.dart';
import 'package:quiz_app/widgets/result_page.dart';

class QuizStartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => QuizBloc(quizRepository: QuizRepository())),
        ],
        child: Scaffold(body: BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
          if (state.quizStatus == QuizStatus.INITIAL||state.quizStatus == QuizStatus.GET_READY) {
            return Container(child: Center(child: GetReady()));
          }if (state.quizStatus == QuizStatus.RESULT) {
            return ResultPage();
          }
          return FadeRoute(page: QuestionPage())
              .page; //Container(child: Text('welcome in quiz app'),);
        })));
  }
}
