import 'package:flutter/material.dart';

///Add * to separate the text for two different color
class TwoColorText extends StatelessWidget {
  final TextStyle _textStyle;
  final String text;

  Size get size => (TextPainter(
        text: TextSpan(text: "GOGAME", style: _textStyle),
        maxLines: 1,
        textDirection: TextDirection.ltr,
      )..layout())
          .size;

  TwoColorText({double fontSize = 26.0, TextStyle textStyle, this.text})
      : assert(text != null && text.contains('*')),
        _textStyle = textStyle ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
            );
  @override
  Widget build(BuildContext context) {
    List<String> texts = text.split("*");
    return RichText(
      text: TextSpan(
        children: <TextSpan>[
          TextSpan(
            style: TextStyle(color: Colors.orange),
            text: texts[0],
          ),
          TextSpan(
            style: TextStyle(color: Colors.black),
            text: texts[1],
          ),
        ],
        style: _textStyle,
      ),
    );
  }
}
