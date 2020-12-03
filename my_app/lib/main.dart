import 'package:flutter/material.dart';
import 'package:my_app/notification.dart';
import 'package:provider/provider.dart';
import 'home-widget.dart';
import 'theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotificationManager(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: myThemeData,
        home: HomeWidget(),
      ),
    );
  }
}
