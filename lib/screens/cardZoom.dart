import 'package:flutter/material.dart';
//import 'package:flutter/scheduler.dart' show timeDilation;
import '../models/gameCard.dart';

class CardZoom extends StatefulWidget {
  final GameCard gameCard;

  CardZoom(this.gameCard);

  @override
  State<StatefulWidget> createState() {
    return CardZoomState(this.gameCard);
  }
}

class CardZoomState extends State<CardZoom> {
  GameCard gameCard;
  CardZoomState(this.gameCard);
  @override
  Widget build(BuildContext context) {
    //timeDilation = 5.0;
    return Scaffold(

      backgroundColor: Colors.black,
      //appBar: AppBar(title: Text(gameCard.name)),
      body: Container(

        alignment: Alignment.bottomCenter,
        child: Hero(

          tag: 'heroZDetalu',
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Image.asset(
              'assets/cards_big/' + this.gameCard.name + '.jpg',
              scale: (1.4),
            ),
          ),
        ),
      ),
    );
  }
}
