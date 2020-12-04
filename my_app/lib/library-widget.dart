import 'package:flutter/material.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'theme.dart';

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
    return Container(
      child: Column(
        children: [
          Container(
            width: 360,
            height: 194,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage('./lib/images/Library.png'),
              fit: BoxFit.fill,
            )),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child:
                          Text(title, style: myThemeData.textTheme.headline6),
                    ),
                    NotificationIcon(this.title),
                  ],
                ),
                SizedBox(height: 10),
                Text("Description", style: myThemeData.textTheme.caption),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                Text(subtitle, style: myThemeData.textTheme.caption),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 8),
                    Text("Opened 09:30 - 19:00",
                        style: myThemeData.textTheme.caption),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.phone, color: myThemeData.primaryColor),
                    SizedBox(width: 8),
                    Text("21 782 3458", style: myThemeData.textTheme.caption),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(16),
                child: RaisedButton.icon(
                  textColor: Color(0xFFFFFFFF),
                  color: myThemeData.accentColor,
                  label: Text("GO"),
                  icon: Icon(Icons.near_me),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
