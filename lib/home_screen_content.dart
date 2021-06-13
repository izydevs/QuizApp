import 'package:flutter/material.dart';
import 'package:quiz_app/utils/images.dart';
import 'package:quiz_app/utils/strings.dart';
import 'package:quiz_app/widgets/two_color_text.dart';

import 'widgets/game_card.dart';

class HomeScreenContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 128),
          TwoColorText(
            text: ourGames,
            textStyle: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              ourGameDescription,
              textAlign: TextAlign.center,
            ),
          ),
          GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, childAspectRatio: 1),
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: carouselImages.length,
            itemBuilder: (_, index) => GameCard(
              image: carouselImages[index],
              text: gameNames[index],
            ),
          ),
        ],
      ),
    );
  }
}
