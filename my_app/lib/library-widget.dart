import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/capacity-info-widget.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'package:my_app/sitemap-widget.dart';
import 'package:my_app/common/string-utils.dart';
import 'theme.dart';

class LibraryWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> library = {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: databaseReference.child("places/library").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            DataSnapshot dataValues = snapshot.data.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            values.forEach((key, value) {
              library[key] = value;
            });

            return LibraryInfoWidget(library);
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class LibraryInfoWidget extends StatelessWidget {
  final library;

  LibraryInfoWidget(this.library);

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
              image: AssetImage(library["image"]),
              fit: BoxFit.fitWidth,
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
                      child: Text(library["name"],
                          style: myThemeData.textTheme.headline6),
                    ),
                    NotificationIcon(library["type"]),
                  ],
                ),
                SizedBox(height: 10),
                library["description"] != null
                    ? Text(library["description"],
                        style: myThemeData.textTheme.caption)
                    : Container(),
                Divider(),
                SizedBox(height: 10),
                Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                SizedBox(height: 10),
                CapacityInfoWidget(library["capacity"]),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 16),
                    Text(
                        getOpeningString(
                            library["open"]["hour"],
                            library["open"]["minute"],
                            library["close"]["hour"],
                            library["close"]["minute"]),
                        style: myThemeData.textTheme.caption),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.phone, color: myThemeData.primaryColor),
                    SizedBox(width: 16),
                    Text(library["phoneNumber"],
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
                child: RaisedButton.icon(
                  textColor: Colors.white,
                  label: Text("GO"),
                  icon: Icon(Icons.near_me),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SiteMapWidget(library)));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
