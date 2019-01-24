import 'package:flutter/material.dart';
import '../database.dart';
import '../models/gameCard.dart';
import 'cardDetail.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class GameCardList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return GameCardListState();
  }
}

class GameCardListState extends State<GameCardList> {
  int count = 0;
  bool redVal = false,
      blackVal = false,
      blueVal = false,
      greenVal = false,
      noneVal = false,
      basicVal = false,
      commonVal = false,
      uncommonVal = false,
      rareVal = false,
      heroVal = false,
      creepVal = false,
      itemVal = false,
      spellVal = false,
      improvementVal = false;

  TextEditingController searchController = TextEditingController();
  String query = "SELECT * FROM cards ";
  DBProvider dbProvider = DBProvider();
  List<GameCard> gameCardList;


  @override
  Widget build(BuildContext context) {
    if (gameCardList == null) {
      gameCardList = List<GameCard>();
      updateGridView();
    }


    var gv = new GridView.builder(
      itemCount: count,
      gridDelegate:
          new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemBuilder: (BuildContext context, int index) {
        return new GestureDetector(
          child: Card(
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
    );

    return new Scaffold(
      appBar: AppBar(
        title: Text("Lista kart"),
        backgroundColor: Colors.indigo[800],

      ),
      drawer: Drawer(
          child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 150,
            child: DrawerHeader(
              child: Column(children: <Widget>[
                Text("Wyszukiwanie"),
                TextField(
                  controller: searchController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(1))),
                  onChanged: (text) {
                    query = "SELECT * FROM cards ";
                    if (text == "") {
                      query = "SELECT * FROM cards ";
                    } else {
                      query = query + "WHERE name LIKE '%" + text + "%'";
                    }
                    updateGridView2();
                  },
                ),
              ]),
              //child: Text("Wyszukiwanie"),
              decoration: BoxDecoration(color: Colors.indigo[900]),
            ),
          ),
          ExpansionTile(
            title: Text("Kolor"),
            children: <Widget>[
              CheckboxListTile(
                title: Text("Czerwony"),
                value: redVal,
                onChanged: (bool value) {
                  setState(() {
                    redVal = value;
                  });
                  if (blackVal ||
                      greenVal ||
                      blueVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (redVal == true) {
                      query = query + "OR color='red'";
                    } else {
                      query = query.replaceFirst("OR color='red'", "");
                    }
                  } else {
                    if (redVal == true) {
                      query = query + "WHERE color='red'";
                    } else {
                      query = query.replaceFirst("WHERE color='red'", "");
                    }
                  }

                  debugPrint("red " + redVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Czarny"),
                value: blackVal,
                onChanged: (bool value) {
                  setState(() {
                    blackVal = value;
                  });
                  if (redVal ||
                      greenVal ||
                      blueVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (blackVal == true) {
                      query = query + "OR color='black'";
                    } else {
                      query = query.replaceFirst("OR color='black'", "");
                    }
                  } else {
                    if (blackVal == true) {
                      query = query + "WHERE color='black'";
                    } else {
                      query = query.replaceFirst("WHERE color='black'", "");
                    }
                  }

                  debugPrint("black " + blackVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Niebieski"),
                value: blueVal,
                onChanged: (bool value) {
                  setState(() {
                    blueVal = value;
                  });
                  if (blackVal ||
                      greenVal ||
                      redVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (blueVal == true) {
                      query = query + "OR color='blue'";
                    } else {
                      query = query.replaceFirst("OR color='blue'", "");
                    }
                  } else {
                    if (blueVal == true) {
                      query = query + "WHERE color='blue'";
                    } else {
                      query = query.replaceFirst("WHERE color='blue'", "");
                    }
                  }

                  debugPrint("blue " + blueVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Zielony"),
                value: greenVal,
                onChanged: (bool value) {
                  setState(() {
                    greenVal = value;
                  });
                  if (blackVal ||
                      redVal ||
                      blueVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (greenVal == true) {
                      query = query + "OR color='green'";
                    } else {
                      query = query.replaceFirst("OR color='green'", "");
                    }
                  } else {
                    if (greenVal == true) {
                      query = query + "WHERE color='green'";
                    } else {
                      query = query.replaceFirst("WHERE color='green'", "");
                    }
                  }

                  debugPrint("green " + greenVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Brak"),
                value: noneVal,
                onChanged: (bool value) {
                  setState(() {
                    noneVal = value;
                  });
                  if (blackVal ||
                      redVal ||
                      blueVal ||
                      greenVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (noneVal == true) {
                      query = query + "OR color IS NULL";
                    } else {
                      query = query.replaceFirst("OR color IS NULL", "");
                    }
                  } else {
                    if (noneVal == true) {
                      query = query + "WHERE color IS NULL";
                    } else {
                      query = query.replaceFirst("WHERE color IS NULL", "");
                    }
                  }
                  debugPrint("none " + noneVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Rzadkość"),
            children: <Widget>[
              CheckboxListTile(
                title: Text("Basic"),
                value: basicVal,
                onChanged: (bool value) {
                  setState(() {
                    basicVal = value;
                  });
                  if (blackVal ||
                      greenVal ||
                      blueVal ||
                      noneVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (basicVal == true) {
                      query = query + "OR rarity='basic'";
                    } else {
                      query = query.replaceFirst("OR rarity='basic'", "");
                    }
                  } else {
                    if (basicVal == true) {
                      query = query + "WHERE rarity='basic'";
                    } else {
                      query = query.replaceFirst("WHERE rarity='basic'", "");
                    }
                  }

                  debugPrint("basic " + basicVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Common"),
                value: commonVal,
                onChanged: (bool value) {
                  setState(() {
                    commonVal = value;
                  });
                  if (redVal ||
                      greenVal ||
                      blueVal ||
                      noneVal ||
                      basicVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (commonVal == true) {
                      query = query + "OR rarity='common'";
                    } else {
                      query = query.replaceFirst("OR rarity='common'", "");
                    }
                  } else {
                    if (commonVal == true) {
                      query = query + "WHERE rarity='common'";
                    } else {
                      query = query.replaceFirst("WHERE rarity='common'", "");
                    }
                  }

                  debugPrint("common " + commonVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Uncommon"),
                value: uncommonVal,
                onChanged: (bool value) {
                  setState(() {
                    uncommonVal = value;
                  });
                  if (blackVal ||
                      greenVal ||
                      redVal ||
                      noneVal ||
                      commonVal ||
                      basicVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (uncommonVal == true) {
                      query = query + "OR rarity='uncommon'";
                    } else {
                      query = query.replaceFirst("OR rarity='uncommon'", "");
                    }
                  } else {
                    if (uncommonVal == true) {
                      query = query + "WHERE rarity='uncommon'";
                    } else {
                      query = query.replaceFirst("WHERE rarity='uncommon'", "");
                    }
                  }

                  debugPrint("uncommon " + uncommonVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Rare"),
                value: rareVal,
                onChanged: (bool value) {
                  setState(() {
                    rareVal = value;
                  });
                  if (blackVal ||
                      redVal ||
                      blueVal ||
                      noneVal ||
                      commonVal ||
                      uncommonVal ||
                      basicVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (rareVal == true) {
                      query = query + "OR rarity='rare'";
                    } else {
                      query = query.replaceFirst("OR rarity='rare'", "");
                    }
                  } else {
                    if (rareVal == true) {
                      query = query + "WHERE rarity='rare'";
                    } else {
                      query = query.replaceFirst("WHERE rarity='rare'", "");
                    }
                  }

                  debugPrint("rare " + rareVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Typ"),
            children: <Widget>[
              CheckboxListTile(
                title: Text("Hero"),
                value: heroVal,
                onChanged: (bool value) {
                  setState(() {
                    heroVal = value;
                  });
                  if (blackVal ||
                      greenVal ||
                      blueVal ||
                      redVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      creepVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (heroVal == true) {
                      query = query + "OR type='hero'";
                    } else {
                      query = query.replaceFirst("OR type='hero'", "");
                    }
                  } else {
                    if (heroVal == true) {
                      query = query + "WHERE type='hero'";
                    } else {
                      query = query.replaceFirst("WHERE type='hero'", "");
                    }
                  }

                  debugPrint("hero " + heroVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Item"),
                value: itemVal,
                onChanged: (bool value) {
                  setState(() {
                    itemVal = value;
                  });
                  if (redVal ||
                      greenVal ||
                      blueVal ||
                      blackVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      spellVal ||
                      improvementVal) {
                    if (itemVal == true) {
                      query = query + "OR type='item'";
                    } else {
                      query = query.replaceFirst("OR type='item'", "");
                    }
                  } else {
                    if (itemVal == true) {
                      query = query + "WHERE type='item'";
                    } else {
                      query = query.replaceFirst("WHERE type='item'", "");
                    }
                  }

                  debugPrint("item " + itemVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Creep"),
                value: creepVal,
                onChanged: (bool value) {
                  setState(() {
                    creepVal = value;
                  });
                  if (blackVal ||
                      greenVal ||
                      redVal ||
                      blueVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      itemVal ||
                      spellVal ||
                      improvementVal) {
                    if (creepVal == true) {
                      query = query + "OR type='creep'";
                    } else {
                      query = query.replaceFirst("OR type='creep'", "");
                    }
                  } else {
                    if (creepVal == true) {
                      query = query + "WHERE type='creep'";
                    } else {
                      query = query.replaceFirst("WHERE type='creep'", "");
                    }
                  }

                  debugPrint("creep " + creepVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Spell"),
                value: spellVal,
                onChanged: (bool value) {
                  setState(() {
                    spellVal = value;
                  });
                  if (blackVal ||
                      redVal ||
                      blueVal ||
                      greenVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      improvementVal) {
                    if (spellVal == true) {
                      query = query + "OR type='spell'";
                    } else {
                      query = query.replaceFirst("OR type='spell'", "");
                    }
                  } else {
                    if (spellVal == true) {
                      query = query + "WHERE type='spell'";
                    } else {
                      query = query.replaceFirst("WHERE type='spell'", "");
                    }
                  }

                  debugPrint("spell " + spellVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
              CheckboxListTile(
                title: Text("Improvement"),
                value: improvementVal,
                onChanged: (bool value) {
                  setState(() {
                    improvementVal = value;
                  });
                  if (blackVal ||
                      redVal ||
                      blueVal ||
                      greenVal ||
                      noneVal ||
                      basicVal ||
                      commonVal ||
                      uncommonVal ||
                      rareVal ||
                      heroVal ||
                      creepVal ||
                      itemVal ||
                      spellVal) {
                    if (improvementVal == true) {
                      query = query + "OR type='improvement'";
                    } else {
                      query = query.replaceFirst("OR type='improvement'", "");
                    }
                  } else {
                    if (improvementVal == true) {
                      query = query + "WHERE type='improvement'";
                    } else {
                      query =
                          query.replaceFirst("WHERE type='improvement'", "");
                    }
                  }
                  debugPrint("improvement " + improvementVal.toString());
                  debugPrint(query);
                  updateGridView2();
                },
              ),
            ],
          ),
        ],
      )),
      body: gv,
    );
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

  void changeBoolVal(bool val) {
    setState(() {
      val = !val;
    });
  }

  void navigateToDetail(GameCard gamecard) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CardDetail(gamecard);
    }));
  }

  void updateGridView() {
    final Future<Database> dbFuture = dbProvider.initDB();
    dbFuture.then((database) {
      Future<List<GameCard>> gameCardListFuture = dbProvider.getCardList();
      gameCardListFuture.then((gameCardList) {
        setState(() {
          this.gameCardList = gameCardList;
          this.count = gameCardList.length;
        });
      });
    });
  }

  void updateGridView2() {
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
