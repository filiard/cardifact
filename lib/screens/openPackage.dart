import 'package:flutter/material.dart';
import '../database.dart';
import '../models/gameCard.dart';
import 'cardDetail.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'dart:math';

class OpenPackage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OpenPackageState();
  }
}

class OpenPackageState extends State<OpenPackage> {
  int count = 0;
  String query = "SELECT * FROM cards ";
  DBProvider dbProvider = DBProvider();
  List<GameCard> gameCardList;

  @override
  Widget build(BuildContext context) {
    if (gameCardList == null) {
      gameCardList = List<GameCard>();
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
          tooltip: "Otwórz",
          child: Icon(Icons.open_in_new),
          backgroundColor: Colors.purple,
          onPressed: () {
            getRandomCards();
            debugPrint("FAB");
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: new AppBar(
        title: Text("Otwieranie paczki"),
        backgroundColor: Colors.purple[800],
      ),
      body: GridView.builder(
        itemCount: count,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return new GestureDetector(
            child: new Card(
              elevation: 5.0,
              child: GridTile(
                header: new GridTileBar(
                  backgroundColor: getCardColor(this.gameCardList[index].color),
                  title: new Text(this.gameCardList[index].name),
                ),
                child: Image.asset('assets/cards_small/' +
                    this.gameCardList[index].name +
                    '.jpg'),
                footer: new Container(
                  child: new Text(
                    this.gameCardList[index].type,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70),
                  ),
                  color: getCardColor(this.gameCardList[index].color)
                      .withOpacity(0.3),
                ),
              ),
            ),
            onTap: () {
              debugPrint("klik " +
                  index.toString() +
                  " " +
                  this.gameCardList[index].name);
              navigateToDetail(this.gameCardList[index]);
            },
          );
        },
      ),
    );
  }

  void navigateToDetail(GameCard gamecard) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CardDetail(gamecard);
    }));
  }

  Color getCardColor(String color) {
    if (color == "red") return Color(0x55ad0000);
    if (color == "blue") return Color(0x55000acc);
    if (color == "green") return Color(0x55008c0b);
    if (color == "black")
      return Color(0x88000000);
    else
      return Color(0x77888888);
  }

  void updateGridView() {
    final Future<Database> dbFuture = dbProvider.initDB();
    dbFuture.then((database) {
      Future<List<GameCard>> gameCardListFuture =
          dbProvider.getFilteredCardList(query);
      gameCardListFuture.then((gameCardList) {
        setState(() {
          this.gameCardList = gameCardList;
          this.count = gameCardList.length;
        });
      });
    });
  }

  void getRandomCards() {
    String query = "SELECT * FROM cards ORDER BY RANDOM() LIMIT 12";
    final Future<Database> dbFuture = dbProvider.initDB();
    dbFuture.then((database) {
      Future<List<GameCard>> gameCardListFuture =
          dbProvider.getFilteredCardList(query);
      gameCardListFuture.then((gameCardList) {
        setState(() {
          this.gameCardList = gameCardList;
          this.count = gameCardList.length;
        });
      });
    });
  }
}
