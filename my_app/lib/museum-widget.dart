import 'package:flutter/material.dart';

class MuseumWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MuseumWidgetState();
  }
}

class _MuseumWidgetState extends State<MuseumWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Museum"),
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
