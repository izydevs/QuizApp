import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiz_app/bloc/quiz_bloc.dart';

class GetReady extends StatefulWidget {
  @override
  _GetReadyState createState() => _GetReadyState();
}

class _GetReadyState extends State<GetReady> {
  Timer _timer;
  final StreamController<String> _timerCount = StreamController.broadcast();
  final int _start = 3;

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
      return Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Get Ready for ${state.quizStatus==QuizStatus.INITIAL?'first':'next'} question!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: Colors.indigo),
              ),
              StreamBuilder<Object>(
                  stream: _timerCount.stream,
                  builder: (context, snapshot) {
                    if (snapshot?.data!=null && snapshot.data != '0' ) {
                      return Text(
                        snapshot.data,
                        style: TextStyle(
                            fontSize: 48, fontWeight: FontWeight.w700, color: Colors.lightBlue),
                      );
                    } else {
                      if(snapshot.data!=null && snapshot.data=='0'){context.read<QuizBloc>().add(NavigateToQuestionPage());}
                      return Text(
                        '3',
                        style: TextStyle(
                            fontSize: 48, fontWeight: FontWeight.w700, color: Colors.lightBlue),
                      );
                    }
                  })
            ],
          ),
        ),
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
        _timerCount.add('$_start');
      }
    });
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    _timerCount.close();
    super.dispose();
  }
}
