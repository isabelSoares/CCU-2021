import 'package:flutter/material.dart';
import 'package:my_app/new-event-notification-widget.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/new-place-notification-widget.dart';
import 'package:my_app/notification.dart';
import 'theme.dart';

class NotificationsWidget extends StatelessWidget {
  NotificationsWidget();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Notifications"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "RECENT"),
              Tab(text: "SCHEDULED"),
            ],
          ),
        ),
        // floatingActionButton: SpeedDial(
        //   // animatedIcon: AnimatedIcons.add_event,
        //   // animatedIconTheme: IconThemeData(size: 22.0),
        //   child: Icon(Icons.add),
        //   overlayColor: Colors.black,
        //   overlayOpacity: 0.5,
        //   children: [
        //     SpeedDialChild(
        //       child: Icon(Icons.accessibility),
        //       backgroundColor: Colors.white,
        //       label: "Places",
        //       // labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {},
        //     ),
        //     SpeedDialChild(
        //       child: IconButton(
        //           icon: FaIcon(FontAwesomeIcons.utensils,
        //               color: myThemeData.accentColor),
        //           onPressed: () {
        //             Navigator.pop(context);
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) => NewNotificationWidget()));
        //           }),
        //       backgroundColor: Colors.white,
        //       label: "Dishes",
        //       // labelStyle: TextStyle(fontSize: 18.0),
        //       // onTap: () {},
        //     ),
        //     SpeedDialChild(
        //       child: FaIcon(FontAwesomeIcons.music,
        //           color: myThemeData.accentColor),
        //       backgroundColor: Colors.white,
        //       label: "Events",
        //       // labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {},
        //     ),
        //     SpeedDialChild(
        //       child: FaIcon(FontAwesomeIcons.university,
        //           color: myThemeData.accentColor),
        //       backgroundColor: Colors.white,
        //       label: "Exhibitions",
        //       // labelStyle: TextStyle(fontSize: 18.0),
        //       onTap: () {},
        //     )
        //   ],
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _notificationsModalBottomSheet(context);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (context) => NewNotificationWidget()));
          },
          child: Icon(Icons.add),
          backgroundColor: myThemeData.accentColor,
        ),
        body: TabBarView(
          children: [
            _NotificationsList(),
            _NotificationsList(),
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
                ListTile(
                  leading: FaIcon(FontAwesomeIcons.university),
                  title: Text("Exhibitions"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          );
        });
  }
}

class _NotificationsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var manager = context.watch<NotificationManager>();

    return ListView.separated(
      separatorBuilder: (context, index) => Divider(),
      itemCount: manager.notifications.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(manager.notifications[index].title()),
        subtitle: Text(manager.notifications[index].subtitle()),
        enabled: true,
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            manager.remove(manager.notifications[index]);
          },
        ),
      ),
    );
  }
}
