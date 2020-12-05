import 'package:flutter/material.dart';
import 'package:my_app/capacity-info-widget.dart';
import 'package:my_app/common/places.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'theme.dart';

class LibraryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(library.type),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: LibraryInfoWidget(library),
    );
  }
}

class LibraryInfoWidget extends StatelessWidget {
  final Library library;

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
              image: AssetImage(library.image),
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
                      child: Text(library.name,
                          style: myThemeData.textTheme.headline6),
                    ),
                    NotificationIcon(library.type),
                  ],
                ),
                SizedBox(height: 10),
                library.description != null
                    ? Text(library.description,
                        style: myThemeData.textTheme.caption)
                    : Container(),
                Divider(),
                SizedBox(height: 10),
                Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                SizedBox(height: 10),
                CapacityInfoWidget(library.capacity),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 16),
                    Text(library.getOpeningString(),
                        style: myThemeData.textTheme.caption),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.phone, color: myThemeData.primaryColor),
                    SizedBox(width: 16),
                    Text(library.phoneNumber,
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
