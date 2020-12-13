import 'package:flutter/material.dart';
import 'package:my_app/home-widget.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LivinGulbenkian',
      theme: myThemeData,
      home: HomeWidget(),
    );
  }
}
