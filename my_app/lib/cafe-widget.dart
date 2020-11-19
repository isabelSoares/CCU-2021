import 'package:flutter/material.dart';

class CafeWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _CafeWidgetState();
  }
}

class _CafeWidgetState extends State<CafeWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafe"),
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
