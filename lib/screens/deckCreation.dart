import 'package:flutter/material.dart';
import '../database.dart';
import '../models/gameCard.dart';
import 'cardDetail.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class DeckCreation extends StatefulWidget{

  @override
  State<StatefulWidget> createState(){
    return DeckCreationState();
  }

}

class DeckCreationState extends State<DeckCreation>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.teal[800], title: Text("Nowa talia"),),
      body: Text("asdasds")
    );
  }
}