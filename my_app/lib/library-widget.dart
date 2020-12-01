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
      body: LibraryInfoWidget("Library", "70%"),
    );
  }
}

class LibraryInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  LibraryInfoWidget(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 360,
            height: 194,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('./lib/images/Library.png'),
                fit : BoxFit.fill,
              )
            ),
          ),
          Text(title, style: myThemeData.textTheme.headline6),
          Text("Description", style: myThemeData.textTheme.caption),
          Divider(),
          Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
          Text(subtitle, style: myThemeData.textTheme.caption),
          Divider(),
          Row(
            children: [
              Icon(Icons.access_time, color: myThemeData.primaryColor),
              Text("Opened 09:30am - 19pm", style: myThemeData.textTheme.caption),
            ],
          ),
          Row(
            children: [
              Icon(Icons.phone_local, color: myThemeData.primaryColor),
              Text("21 782 3458", style: myThemeData.textTheme.caption),
            ],
          ),
          Row(
            children: [
              Icon(Icons.notifications_none, color: myThemeData.primaryColor),
            ],
          ),
          Row(
            children: [
              Icon(Icons.notifications, color: myThemeData.primaryColor),
            ],
          ),
          RaisedButton.icon(
            textColor: Color(0xFFFFFFFF),
            color: myThemeData.accentColor,
            label: Text("GO", style: myThemeData.textTheme.button),
            icon: Icon(Icons.near_me),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
