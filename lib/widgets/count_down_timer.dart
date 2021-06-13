import 'package:flutter/material.dart';

class CountDownTimer extends StatefulWidget {
  final AnimationController controller;
  CountDownTimer({this.controller});
  @override
  _CountDownTimerState createState() => _CountDownTimerState(controller: controller);
}

class _CountDownTimerState extends State<CountDownTimer> with TickerProviderStateMixin {
  AnimationController controller;
  _CountDownTimerState({this.controller});

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${duration.inMinutes}:${(duration.inSeconds+1 % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,width: 150,
      child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Align(
                      alignment: FractionalOffset.center,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: AnimatedBuilder(
                                animation: controller,
                                builder: (BuildContext context, Widget child) {
                                  return CustomPaint(
                                      painter: CustomTimerPainter(
                                    animation: controller,
                                    backgroundColor: Colors.lightBlueAccent.withOpacity(0.5),
                                    color: Colors.lightBlue,
                                  ));
                                },
                              ),
                            ),
                            Align(
                              alignment: FractionalOffset.center,
                              child: AnimatedBuilder(
                                  animation: controller,
                                  builder: (BuildContext context, Widget child) {
                                    return Text(
                                      timerString,
                                      style: TextStyle(fontSize: 36.0, color: Colors.lightBlue),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 15.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * 3.14;
    canvas.drawArc(Offset.zero & size, 3.14 * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
