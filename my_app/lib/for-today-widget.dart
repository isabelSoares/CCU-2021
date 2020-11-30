import 'package:flutter/material.dart';
import 'package:my_app/custom-drawer-widget.dart';

class ForTodayWidget extends StatelessWidget {
  ForTodayWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("For today")),
      drawer: CustomDrawerWidget(),
    );
  }
}
