import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/common/string-utils.dart';
import 'package:my_app/cafeMenu-widget.dart';
import 'package:my_app/capacity-info-widget.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'package:my_app/sitemap-widget.dart';
import 'theme.dart';

class CafeWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> cafe = {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Cafe"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: databaseReference.child("places/cafe").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            DataSnapshot dataValues = snapshot.data.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            values.forEach((key, value) {
              cafe[key] = value;
            });

            return CafeInfoWidget(cafe);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CafeInfoWidget extends StatelessWidget {
  final cafe;

  CafeInfoWidget(this.cafe);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            // width: 360,
            height: 194,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(cafe["image"]),
                fit: BoxFit.fitWidth,
              ),
            ),
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
                      child: Text(cafe["name"],
                          style: myThemeData.textTheme.headline6),
                    ),
                    NotificationIcon(cafe["type"]),
                  ],
                ),
                SizedBox(height: 10),
                cafe["description"] != null
                    ? Text(cafe["description"],
                        style: myThemeData.textTheme.caption)
                    : Container(),
                Divider(),
                SizedBox(height: 10),
                Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                SizedBox(height: 10),
                CapacityInfoWidget(cafe["capacity"]),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 16),
                    Text( getOpeningString(
                            cafe["open"]["hour"],
                            cafe["open"]["minute"],
                            cafe["close"]["hour"],
                            cafe["close"]["minute"]),
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
                        textColor: Colors.white,
                        label: Text("MENU"),
                        icon: Icon(Icons.local_restaurant),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CafeMenuWidget()));
                        },
                      ),
                      SizedBox(width: 8),
                      RaisedButton.icon(
                        textColor: Colors.white,
                        label: Text("GO"),
                        icon: Icon(Icons.near_me),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SiteMapWidget(cafe)));
                        },
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
