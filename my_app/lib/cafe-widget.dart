import 'package:flutter/material.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'theme.dart';

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
      body: CafeInfoWidget("Cafe", "50%"),
    );
  }
}

class CafeInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  CafeInfoWidget(this.title, this.subtitle);

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
              image: AssetImage('./lib/images/Cafe.png'),
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
                    NotificationIcon(title),
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
                    Text("Opened 10am - 18pm",
                        style: myThemeData.textTheme.caption),
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
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      RaisedButton.icon(
                        label: Text("MENU"),
                        icon: Icon(Icons.local_restaurant),
                        onPressed: () {},
                      ),
                      SizedBox(width: 8),
                      RaisedButton.icon(
                        label: Text("GO"),
                        icon: Icon(Icons.near_me),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
