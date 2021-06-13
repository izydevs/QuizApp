import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz_bloc.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/utils/utils.dart';
import 'package:quiz_app/widgets/count_down_timer.dart';
import 'package:quiz_app/widgets/option_card.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> with TickerProviderStateMixin {
  AnimationController controller;
  Timer _timer;
  final StreamController<int> _timerCount = StreamController.broadcast();
  final int _start = 5;

  @override
  void initState() {
    startTimer();
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(builder: (contexts, state) {
      return SafeArea(
        child: Scaffold(
            body: StreamBuilder<Object>(
                stream: _timerCount.stream,
                builder: (context, snapshot) {
                  if (snapshot.data != null && snapshot.data == 0.0) {
                    var quiz = QuizModel(
                        question: Utils.questions[0],
                        answer: Utils.answer[0],
                        answered: '',
                        answerTime: 0);
                    contexts.read<QuizBloc>().add(SubmitAnswer(quiz));
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('My Quiz',
                            style: TextStyle(
                                fontSize: 48, fontWeight: FontWeight.w700, color: Colors.indigo)),
                        SizedBox(
                          height: 20,
                        ),
                        CountDownTimer(
                          controller: controller,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('Question ${state.quizNo}.\n${Utils.questions[0]}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700, color: Colors.indigo)),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.width,
                          child: GridView.builder(
                            itemCount: 4,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                            itemBuilder: (BuildContext context, int index) {
                              return InkWell(
                                onTap: () {
                                  if (controller.isAnimating) controller.stop();
                                  if (_timer != null) _timer.cancel();
                                  Utils.chosenAnswer(index, snapshot.data ?? 1, context, (val) {
                                    contexts.read<QuizBloc>().add(SubmitAnswer(val));
                                  });
                                },
                                child: OptionCard(index: index),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                })),
      );
    });
  }

  void startTimer() {
    print('timer starting...');
    var _start = this._start;
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      if (_start < 1) {
        timer.cancel();
      } else {
        _start = _start - 1;
        _timerCount.add(_start);
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    _timerCount.close();
    controller.dispose();
    super.dispose();
  }
}
