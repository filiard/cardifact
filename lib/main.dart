import 'package:flutter/material.dart';
import 'home.dart';
import 'screens/cardList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cardifact',
      home: Home(),
    );
  }
}
