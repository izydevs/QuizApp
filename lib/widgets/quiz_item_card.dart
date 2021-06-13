import 'package:flutter/material.dart';
import 'package:quiz_app/model/quiz_model.dart';

class QuizItemCard extends StatelessWidget {
  final QuizModel quizModel;

  QuizItemCard({this.quizModel});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(quizModel.question),
            Divider(
              color: Colors.grey,
            ),
            quizModel.answer != quizModel.answered && quizModel.answered.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quizModel.answered,
                        style: TextStyle(color: Colors.red),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(quizModel.answer, style: TextStyle(color: Colors.green)),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  )
                : Container(),
            Text(quizModel.answered.isEmpty
                ? 'Not Answered'
                : 'Answered in ${quizModel.answerTime}'),
          ],
        ),
      ),
    );
  }
}
