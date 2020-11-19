import 'package:flutter/material.dart';

class LibraryWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _LibraryWidgetState();
  }
}

class _LibraryWidgetState extends State<LibraryWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Library"),
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
