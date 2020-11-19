import 'package:flutter/material.dart';

class MusicWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _MusicWidgetState();
  }
}

class _MusicWidgetState extends State<MusicWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music"),
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
