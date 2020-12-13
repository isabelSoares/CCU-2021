import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'theme.dart';

class RestaurantMenuWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();
  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> menu = {};
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant Menu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
          stream: databaseReference.child("places/restaurant/menu").onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              DataSnapshot dataValues = snapshot.data.snapshot;
              Map<dynamic, dynamic> values = dataValues.value;
              values.forEach((key, value) {
                menu[key] = value;
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 16),
                      Text("Food", style: myThemeData.textTheme.headline6),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: menu["food"].length,
                      itemBuilder: (context, index) =>
                          RestaurantMenuListItem(menu["food"][index], true),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 16),
                      Text("Drinks", style: myThemeData.textTheme.headline6),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: menu["drinks"].length,
                      itemBuilder: (context, index) =>
                          RestaurantMenuListItem(menu["drinks"][index], false),
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class RestaurantMenuListItem extends StatelessWidget {
  final item;
  final bool hasNotification;

  RestaurantMenuListItem(this.item, this.hasNotification);

  @override
  Widget build(BuildContext context) {
    return hasNotification
        ? ListTile(
            title: Text(item["name"], style: myThemeData.textTheme.subtitle1),
            subtitle: Text(item["price"]),
            enabled: true,
            trailing: NotificationDishIcon(item),
          )
        : ListTile(
            title: Text(item["name"], style: myThemeData.textTheme.subtitle1),
            subtitle: Text(item["price"]),
            enabled: true,
          );
  }
}

class NotificationDishIcon extends StatelessWidget {
  final item;
  final databaseReference = FirebaseDatabase.instance.reference();

  NotificationDishIcon(this.item);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseReference
          .child("notifications/scheduled")
          .orderByChild("name")
          .equalTo(item["name"])
          .onValue,
      builder: (context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          DataSnapshot dataValues = snapshot.data.snapshot;
          Map<dynamic, dynamic> values = dataValues.value;

          if (values != null) {
            return IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
                print(values.toString());
                databaseReference
                    .child("notifications/scheduled/" +
                        values.keys.first.toString())
                    .remove();
              },
            );
          } else {
            return IconButton(
              icon: Icon(Icons.notifications_none),
              onPressed: () {
                DatabaseReference itemRef =
                    databaseReference.child("notifications/scheduled").push();
                itemRef.set({
                  "type": "dish",
                  "name": item["name"],
                  "price": item["price"],
                });
              },
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
