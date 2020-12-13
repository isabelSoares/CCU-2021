import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/common/session.dart';
import 'package:my_app/new-place-notification-widget.dart';

class NotificationIcon extends StatelessWidget {
  final String name;
  final databaseReference = FirebaseDatabase.instance.reference();

  NotificationIcon(this.name);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseReference
          .child("notifications/scheduled")
          .orderByChild("name")
          .equalTo(name)
          .onValue,
      builder: (context, AsyncSnapshot<Event> snapshot) {
        if (snapshot.hasData) {
          DataSnapshot dataValues = snapshot.data.snapshot;
          Map<dynamic, dynamic> values = dataValues.value;

          if (values != null) {
            return IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () {
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
                  "type": "place",
                  "name": name,
                  "from": {"hour": 9, "minute": 0},
                  "to": {"hour": 18, "minute": 0},
                  "capacity": 50
                });
                if (!dontShowDialog) {
                  showDialog(
                      context: context,
                      builder: (_) => NotificationAddedDialog(name));
                }
              },
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );

    // hasNotification
    //     ? IconButton(
    //         icon: Icon(Icons.notifications),
    //         onPressed: () {
    //           manager.togglePlaceNotification(name);
    //         },
    //       )
    //     : IconButton(
    //         icon: Icon(Icons.notifications_none),
    //         onPressed: () {
    //           manager.togglePlaceNotification(name);
    //           if (!manager.dontShowDialog) {
    //             showDialog(
    //                 context: context,
    //                 builder: (_) => NotificationAddedDialog(name));
    //           }
    //         },
    //       );
  }
}

class NotificationAddedDialog extends StatefulWidget {
  final String name;
  NotificationAddedDialog(this.name);

  State<StatefulWidget> createState() {
    return _NotificationAddedDialogState();
  }
}

class _NotificationAddedDialogState extends State<NotificationAddedDialog> {
  bool _dontShowDialog = dontShowDialog;

  @override
  Widget build(BuildContext context) {
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
            value: dontShowDialog,
            dense: true,
            contentPadding: EdgeInsets.zero,
            onChanged: (value) {
              setState(() {
                _dontShowDialog = value;
                dontShowDialog = value;
              });
            },
            controlAffinity: ListTileControlAffinity.leading,
          )
        ],
      ),
      actions: [
        RaisedButton(
          textColor: Colors.white,
          child: Text("CLOSE"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        RaisedButton.icon(
          textColor: Colors.white,
          icon: Icon(Icons.edit),
          label: Text("EDIT"),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        NewPlaceNotificationWidget(widget.name)));
          },
        ),
      ],
    );
  }
}
