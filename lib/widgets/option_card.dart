import 'package:flutter/material.dart';
import 'package:quiz_app/utils/utils.dart';

class OptionCard extends StatelessWidget {
  final int index;
  OptionCard({this.index});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 40,
              width: 40,
              child: Center(
                  child: Text(
                    Utils.no[index],
                    style: TextStyle(color: Colors.white),
                  )),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff39a700)),
            ),
            Text(Utils.answer[index]),
          ],
        ),
      ),
    );
  }
}
