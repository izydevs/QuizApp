
import 'package:flutter/material.dart';
import 'package:quiz_app/utils/page_route_builders/fade_route.dart';
import 'package:quiz_app/utils/strings.dart';
import 'package:quiz_app/widgets/two_color_text.dart';

import 'home_page.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  Animation<double> animation;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    animation = CurvedAnimation(
      parent: Tween<double>(begin: 0, end: 0.465).animate(controller),
      curve: Curves.easeInOut,
    );
    Future.delayed(Duration(milliseconds: 600), () {
      controller.forward();
    });

    controller.addListener(
          () {
        if (controller.isCompleted) {
          Navigator.of(context).pushReplacement(
            FadeRoute(
              page: HomePage(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TwoColorText logo = TwoColorText(text: title, fontSize: 26);
    Size logoSize = logo.size;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(
              size.width / 2 - logoSize.width / 2,
              size.height * (0.5 - animation.value),
            ),
            child: child,
          );
        },
        child: Hero(
          tag: "title",
          child: logo,
        ),
      ),
    );
  }
}
