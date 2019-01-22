import 'package:flutter/material.dart';
import '../database.dart';
import '../models/gameCard.dart';
import 'cardDetail.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class OpenedPackage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return OpenedPackageState();
  }
}

class OpenedPackageState extends State<OpenedPackage> {
  @override
  Widget build(BuildContext context) {
    //timeDilation = 5.0;
    return Scaffold(
      appBar: new AppBar(
        title: Text("Otwieranie paczki"),
        backgroundColor: Colors.purple[800],
      ),
      body: Center(
        child: GestureDetector(
          child: Icon(
            Icons.developer_mode,
            size: 180,
          ),
          onTap: () {},
        ),
      ),
    );
  }
}
