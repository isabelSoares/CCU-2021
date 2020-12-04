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
                    child: Text("RECENT"),
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
