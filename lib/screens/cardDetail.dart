import 'package:flutter/material.dart';
import '../database.dart';
import '../models/gameCard.dart';
import 'cardZoom.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class CardDetail extends StatefulWidget {
  //final String appBarTitle;
  final GameCard gameCard;

  CardDetail(this.gameCard);

  @override
  State<StatefulWidget> createState() {
    return CardDetailState(this.gameCard);
  }
}

class CardDetailState extends State<CardDetail> {
  GameCard gameCard;
  DBProvider dbProvider = DBProvider();

  CardDetailState(this.gameCard);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: AppBar(
          title: Text(gameCard.name),
          backgroundColor: Colors.indigo[800],
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    GestureDetector(
                      child: Hero(
                        tag: 'heroZDetalu',
                        child: Image.asset(
                          'assets/cards_small/' + this.gameCard.name + '.jpg',
                          scale: 2,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CardZoom(gameCard);
                        }));
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text("Koszt: ",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                Text(omitNulls(gameCard.goldCost.toString()),
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Mana: ",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                Text(omitNulls(gameCard.manaCost.toString()),
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Zdrowie: ",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                Text(omitNulls(gameCard.health.toString()),
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Atak: ",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                Text(omitNulls(gameCard.attack.toString()),
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Text("Pancerz: ",
                                    style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.w300)),
                                Text(omitNulls(gameCard.armor.toString()),
                                    style: TextStyle(
                                      fontSize: 35,
                                      fontWeight: FontWeight.w900,
                                    ))
                              ],
                            ),
                          ],
                        ))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(capitalize(omitNullsColor(gameCard.color)),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: getCardColor(gameCard.color))),
                      Text(capitalize(omitNulls(gameCard.type)),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w800)),
                      Text(capitalize(omitNulls(gameCard.rarity)),
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w800)),
                    ],
                  ),
                ),
                Text(
                  "Opis: " + gameCard.description,
                  style: TextStyle(fontSize: 17),
                ),
              ],
            )));
  }

  String omitNulls(String data) {
    if (data == null || data == "null")
      return "-";
    else
      return data;
  }

  String omitNullsColor(String data) {
    if (data == null)
      return "No color";
    else
      return data;
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Color getCardColor(String color) {
    if (color == "red") return Color(0xffad0000);
    if (color == "blue") return Color(0xff000acc);
    if (color == "green") return Color(0xff008c0b);
    if (color == "black")
      return Color(0xff000000);
    else
      return Color(0xff555555);
  }

  void navigateToZoom(GameCard gamecard) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CardZoom(gamecard);
    }));
  }
}
