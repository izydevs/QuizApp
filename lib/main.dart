import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/home_page.dart';
import 'package:quiz_app/splash_page.dart';
import 'package:quiz_app/video_player_page.dart';
import 'package:quiz_app/widgets/quiz_page.dart';

class SimpleBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
  }
}

Future<void> main() async {
  Bloc.observer = SimpleBlocObserver();
  runApp(QuizApp());
}

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashPage(),
        '/home_page': (context) => HomePage(),
        '/video_player': (context) => VideoPlayerPage(),
        '/quiz_page': (context) => QuizStartPage()
      },
      initialRoute: '/',
    );
  }
}
