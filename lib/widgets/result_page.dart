import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:quiz_app/bloc/quiz_bloc.dart';
import 'package:quiz_app/model/quiz_model.dart';
import 'package:quiz_app/widgets/quiz_item_card.dart';

class ResultPage extends StatefulWidget {
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizBloc, QuizState>(builder: (context, state) {
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: Text('Quiz Result'),
          actions: [IconButton(icon: Icon(Icons.home), onPressed: (){
            Navigator.pushReplacementNamed(context, '/home_page');
          })],
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  height: 200,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Scorecard',
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                        Text(
                          '${state.quizResult['Answered'].toInt()*2}',
                          style: TextStyle(fontSize: 20),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Max point can be scored is 20',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      'Summary of your report',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Card(
                    child: SizedBox(
                      height: 200,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                            child: PieChart(
                          // colorList: [Colors.green, Colors.lightBlueAccent, Colors.redAccent],
                          dataMap: state.quizResult ?? {},
                          chartType: ChartType.ring,
                        )),
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.quizzes.length ?? 0,
                    itemBuilder: (context, index) {
                      List<QuizModel> models = state.quizzes;
                      return Padding(
                        padding: const EdgeInsets.only(left:16.0,right: 16.0,top: 4.0),
                        child: QuizItemCard(quizModel: models[index]),
                      );
                    }),SizedBox(height: 16.0,)
              ],
            ),
          ),
        ),
      ));
    });
  }
}
