import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/common/string-utils.dart';
import 'package:my_app/new-event-notification-widget.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/new-place-notification-widget.dart';
import 'package:my_app/restaurantMenu-widget.dart';
import 'theme.dart';

class NotificationsWidget extends StatelessWidget {
  NotificationsWidget();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x00FFFFFF),
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: myThemeData.accentColor,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: myThemeData.accentColor,
            ),
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: myThemeData.accentColor, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("RECEIVED"),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border:
                          Border.all(color: myThemeData.accentColor, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text("SCHEDULED"),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _notificationsModalBottomSheet(context);
          },
          child: Icon(Icons.add),
          backgroundColor: myThemeData.accentColor,
        ),
        body: TabBarView(
          children: [
            _NotificationsReceivedList(),
            _NotificationsScheduledList(),
          ],
        ),
      ),
    );
  }

  void _notificationsModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            child: Wrap(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(16),
                  child: Text("New notification",
                      style: myThemeData.textTheme.bodyText1),
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.tree),
                  title: Text("Places"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddPlaceNotificationWidget()));
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.utensils),
                  title: Text("Dishes"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RestaurantMenuWidget()));
                  },
                ),
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.music),
                  title: Text("Events"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AddEventNotificationWidget()));
                  },
                ),
              ],
            ),
          );
        });
  }
}

class _NotificationsReceivedList extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<dynamic> notifications = [];

    return StreamBuilder(
      stream: databaseReference.child("notifications/received").onValue,
      builder: (context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          notifications.clear();
          DataSnapshot dataValues = snapshot.data.snapshot;
          Map<dynamic, dynamic> values = dataValues.value;
          if (values != null) {
            values.forEach((key, value) {
              notifications.add(value);
            });
          }

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: notifications.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(notifications[index]["name"]),
              subtitle: Text(notifications[index]["description"]),
              enabled: true,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  databaseReference
                      .child("notifications/received")
                      .orderByChild("name")
                      .equalTo(notifications[index]["name"])
                      .once()
                      .then((DataSnapshot snapshot) {
                    Map<dynamic, dynamic> values = snapshot.value;
                    databaseReference
                        .child("notifications/received/" +
                            values.keys.first.toString())
                        .remove();
                  });
                },
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class _NotificationsScheduledList extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<dynamic> notifications = [];

    return StreamBuilder(
      stream: databaseReference.child("notifications/scheduled").onValue,
      builder: (context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          notifications.clear();
          DataSnapshot dataValues = snapshot.data.snapshot;
          Map<dynamic, dynamic> values = dataValues.value;
          if (values != null) {
            values.forEach((key, value) {
              notifications.add(value);
            });
          }

          return ListView.separated(
            separatorBuilder: (context, index) => Divider(),
            itemCount: notifications.length,
            itemBuilder: (context, index) => ListTile(
              title: Text(
                  getTitle(notifications[index]["type"], notifications[index])),
              subtitle: Text(getSubtitle(
                  notifications[index]["type"], notifications[index])),
              enabled: true,
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  databaseReference
                      .child("notifications/scheduled")
                      .orderByChild("name")
                      .equalTo(notifications[index]["name"])
                      .once()
                      .then((DataSnapshot snapshot) {
                    Map<dynamic, dynamic> values = snapshot.value;
                    databaseReference
                        .child("notifications/scheduled/" +
                            values.keys.first.toString())
                        .remove();
                  });
                },
              ),
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  String getTitle(String type, dynamic notification) {
    if (type == "place") {
      return getNotificationPlaceTitle(notification["name"]);
    } else if (type == "event") {
      return getNotificationEventTitle(notification["name"]);
    } else if (type == "eventSpecific") {
      return getNotificationEventSpecificTitle(notification["name"]);
    } else if (type == "dish") {
      return getNotificationDishTitle(notification["name"]);
    }
    return "";
  }

  String getSubtitle(String type, dynamic notification) {
    if (type == "place") {
      return getNotificationPlaceSubtitle(
          notification["from"]["hour"],
          notification["from"]["minute"],
          notification["to"]["hour"],
          notification["to"]["minute"],
          notification["capacity"]);
    } else if (type == "event") {
      return getNotificationEventSubtitle(notification["days"]);
    } else if (type == "dish") {
      return getNotificationDishSubtitle(notification["price"]);
    }
    return "";
  }
}
