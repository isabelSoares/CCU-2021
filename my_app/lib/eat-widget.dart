import 'package:flutter/material.dart';

class EatWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _EatWidgetState();
  }
}

class _EatWidgetState extends State<EatWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eat"),
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
