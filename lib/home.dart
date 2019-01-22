import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'database.dart';
import 'screens/cardList.dart';
import 'screens/openPackage.dart';
import 'screens/decksList.dart';



class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<Home> {
  DBProvider dbprovider = DBProvider();
  int _currentIndex = 1;
  final List<Widget> _children = [
    DecksList(),
    GameCardList(),
    OpenPackage(),
  ];
  @override
  Widget build(BuildContext context) {
    final Future<Database> dbFuture = dbprovider.initDB();
    return Scaffold(
//      appBar: AppBar(
//        title: Text('Cardifact'),
//      ),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Colors.teal[800],
            icon: new Icon(Icons.border_all),
            title: new Text('Talie'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.indigo[800],
            icon: new Icon(Icons.contact_mail),
            title: new Text('Karty'),
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.purple[800],
            icon: new Icon(Icons.book),
            title: new Text('Otwórz paczkę'),
          )
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
