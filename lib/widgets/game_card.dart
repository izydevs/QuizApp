import 'package:flutter/material.dart';
import 'package:quiz_app/video_player_page.dart';

class GameCard extends StatelessWidget {
  final String text;
  final String image;

  const GameCard({Key key, this.text, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: InkWell(
        onTap: (){
          Navigator.pushReplacementNamed(context, '/video_player');
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(text),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
