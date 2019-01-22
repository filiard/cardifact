import 'package:flutter/material.dart';
import '../database.dart';
import 'deckCreation.dart';
import '../models/deck.dart';
import 'cardDetail.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DecksList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DecksListState();
  }
}

class DecksListState extends State<DecksList> {
  int count = 4;
  DBProvider dbProvider = DBProvider();
  List<Deck> decksList;
  @override
  Widget build(BuildContext context) {
    if (decksList == null) {
      decksList = List<Deck>();
      updateListView();
    }

    return new Scaffold(
      appBar: new AppBar(
        title: Text("Talie"),
        backgroundColor: Colors.teal[800],
      ),
      body: getDecksListView(),
      floatingActionButton: FloatingActionButton(
          tooltip: "Stwórz nowy",
          child: Icon(Icons.create),
          backgroundColor: Colors.teal,
          onPressed: () {
            createNew();
            debugPrint("FAB");
          }),
    );
  }

  ListView getDecksListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              color: Colors.white,
              elevation: 2.0,
              child: ListTile(
                leading: Icon(Icons.view_array),
                onTap: () {
                  debugPrint("klik na deck");

                },
                title: new Text(this.decksList[index].name),
              ));
        });
  }

  void createNew() async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DeckCreation();
    }));
  }

  void updateListView() {

    final Future <Database> dbFuture = dbProvider.initDecksDB();
    dbFuture.then((database)
    {
     Future<List<Deck>> deckListFuture = dbProvider.getDeckList();
     deckListFuture.then((decksList) {
       setState((){
         this.decksList=decksList;
         this.count=decksList.length;
       });
     });
    });

  }
}
