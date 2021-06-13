
import 'package:flutter/material.dart';

import 'home_screen_content.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  AnimationController drawerController;
  AnimationController carouselController;

  bool isDrawerOpen = false;

  @override
  void initState() {
    drawerController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    carouselController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    )..repeat();
    super.initState();
  }

  @override
  void dispose() {
    drawerController.dispose();
    carouselController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: HomeScreenContent(),
    );
  }
}
