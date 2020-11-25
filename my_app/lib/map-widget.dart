import 'package:flutter/material.dart';
import 'package:my_app/custom-drawer-widget.dart';

class MapWidget extends StatelessWidget {
  MapWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Map")),
      drawer: CustomDrawerWidget(),
    );
  }
}
