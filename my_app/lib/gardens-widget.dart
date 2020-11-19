import 'package:flutter/material.dart';

class GardensWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _GardensWidgetState();
  }
}

class _GardensWidgetState extends State<GardensWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Gardens"),
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
