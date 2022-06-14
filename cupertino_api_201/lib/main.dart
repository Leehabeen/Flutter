import 'package:cupertino_api_201/mainpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: CupertinoApp(
        title: 'CupertinoAPI',
        home: MainPage(),
      ),
    );
  }
}