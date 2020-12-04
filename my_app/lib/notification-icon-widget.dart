import 'package:flutter/material.dart';
import 'package:my_app/common/notification.dart';
import 'package:provider/provider.dart';

class NotificationIcon extends StatefulWidget {
  final String name;

  NotificationIcon(this.name);
  State<StatefulWidget> createState() {
    return _NotificationIconState();
  }
}

class _NotificationIconState extends State<NotificationIcon> {
  @override
  Widget build(BuildContext context) {
    var manager = context.watch<NotificationManager>();
    bool hasNotification = manager.hasPlaceNotification(widget.name);

    return hasNotification
        ? IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              manager.togglePlaceNotification(widget.name);
              setState(() {});
            },
          )
        : IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              manager.togglePlaceNotification(widget.name);
              setState(() {});
            },
          );
  }
}
