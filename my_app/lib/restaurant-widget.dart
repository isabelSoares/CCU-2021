import 'package:flutter/material.dart';
import 'package:my_app/capacity-info-widget.dart';
import 'package:my_app/common/places.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'package:my_app/sitemap-widget.dart';
import 'theme.dart';

class RestaurantWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.type),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RestaurantInfoWidget(restaurant),
    );
  }
}

class RestaurantInfoWidget extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantInfoWidget(this.restaurant);

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
                image: AssetImage(restaurant.image),
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
                      child: Text(restaurant.name,
                          style: myThemeData.textTheme.headline6),
                    ),
                    NotificationIcon(restaurant.type),
                  ],
                ),
                SizedBox(height: 10),
                restaurant.description != null
                    ? Text(restaurant.description,
                        style: myThemeData.textTheme.caption)
                    : Container(),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                SizedBox(height: 10),
                CapacityInfoWidget(restaurant.capacity),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 16),
                    Text(restaurant.getOpeningString(),
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
                        onPressed: () {},
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
                                  builder: (context) =>
                                      SiteMapWidget(restaurant)));
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
