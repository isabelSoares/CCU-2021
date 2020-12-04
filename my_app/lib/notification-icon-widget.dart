import 'package:flutter/material.dart';
import 'package:my_app/common/notification.dart';
import 'package:provider/provider.dart';

class NotificationIcon extends StatelessWidget {
  final String name;

  NotificationIcon(this.name);
  @override
  Widget build(BuildContext context) {
    var manager = context.watch<NotificationManager>();
    bool hasNotification = manager.hasPlaceNotification(name);

    return hasNotification
        ? IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              manager.togglePlaceNotification(name);
            },
          )
        : IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              manager.togglePlaceNotification(name);
              if (!manager.dontShowDialog) {
                showDialog(
                    context: context,
                    builder: (_) => NotificationAddedDialog());
              }
            },
          );
  }
}

class NotificationAddedDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var manager = context.watch<NotificationManager>();

    return AlertDialog(
      title: Text("Notification added"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
              "You will receive a notification from 10:00 to 18:00 when this place has a capacity lower than 50%."),
          SizedBox(height: 16),
          Text("You can always change this values in the notifications menu."),
          SizedBox(height: 16),
          CheckboxListTile(
            title: Text("Don’t show this again"),
            value: manager.dontShowDialog,
            dense: true,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              manager.setDontShowDialog(value);
            },
            controlAffinity: ListTileControlAffinity.leading,
          )
        ],
      ),
      actions: [
        RaisedButton(
          child: Text("CLOSE"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        RaisedButton.icon(
          icon: Icon(Icons.edit),
          label: Text("EDIT"),
          onPressed: () {},
        ),
      ],
    );
  }
}
