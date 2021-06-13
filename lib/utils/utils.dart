import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_model.dart';

class Utils {
  static const List<String> no = ['A', 'B', 'C', 'D'];
  static const List<String> questions = ['Which is the fast animal?', 'B', 'C', 'D'];
  static const List<String> answer = ['Cheetah', 'Turtle', 'Tiger', 'Rabbit'];

  static chosenAnswer(int option, int time, BuildContext context, Function function) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Icon(
                option != 0 ?Icons.check_circle:Icons.cancel_rounded,
                size: 40,
                color: option != 0 ? Colors.red : Colors.green,
              ),
              content: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(option != 0 ? 'Wrong Answer' : 'Correct Answer'),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          var quiz = QuizModel(
                              question: questions[0],
                              answer: answer[0],
                              answered: answer[option],
                              answerTime: time);
                          function(quiz);
                        },
                        child: Container(
                            height: 30,
                            width: 60,
                            decoration:
                                BoxDecoration(shape: BoxShape.rectangle, color: Color(0xff005cff)),
                            child: Center(
                                child: Text(
                              'OK',
                              style: TextStyle(color: Colors.white),
                            ))))
                  ],
                ),
              ),
            ));
  }
}
