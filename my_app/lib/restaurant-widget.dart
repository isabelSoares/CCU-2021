import 'package:flutter/material.dart';

class RestaurantWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _RestaurantWidgetState();
  }
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("restaurant"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Icon(Icons.nature),
    );
  }
}
