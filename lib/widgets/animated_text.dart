import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final List<String> strings;

  const AnimatedText({Key key, this.strings})
      : assert(strings != null),
        super(key: key);
  @override
  _AnimatedTextState createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText>
    with SingleTickerProviderStateMixin {
  Animation<int> _characterCount;
  int _stringIndex;
  String get _currentString =>
      widget.strings[_stringIndex % widget.strings.length];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle = theme.textTheme.title.copyWith();
    return new Scaffold(
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.navigate_next),
        onPressed: () async {
          AnimationController controller = new AnimationController(
            duration: const Duration(milliseconds: 4000),
            vsync: this,
          );
          setState(() {
            _stringIndex = _stringIndex == null ? 0 : _stringIndex + 1;
            _characterCount =
                new StepTween(begin: 0, end: _currentString.length).animate(
              new CurvedAnimation(
                parent: controller,
                curve: Curves.easeIn,
              ),
            );
          });
          await controller.forward();
          controller.dispose();
        },
      ),
      body: new Container(
        margin: new EdgeInsets.symmetric(vertical: 50.0, horizontal: 10.0),
        child: _characterCount == null
            ? null
            : new AnimatedBuilder(
                animation: _characterCount,
                builder: (BuildContext context, Widget child) {
                  String text =
                      _currentString.substring(0, _characterCount.value);
                  return new Text(text, style: textStyle);
                },
              ),
      ),
    );
  }
}
