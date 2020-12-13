import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'theme.dart';

class EventInfoWidget extends StatelessWidget {
  final event;

  EventInfoWidget(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Event"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              // width: 360,
              height: 194,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(event["image"]),
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
                        child: Text(event["name"],
                            style: myThemeData.textTheme.headline6),
                      ),
                      NotificationEventIcon(event["name"]),
                    ],
                  ),
                  SizedBox(height: 10),
                  event["description"] != null
                      ? Text(event["description"],
                          style: myThemeData.textTheme.caption)
                      : Container(),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: myThemeData.primaryColor),
                      SizedBox(width: 16),
                      Text(event["date"], style: myThemeData.textTheme.caption),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NotificationEventIcon extends StatelessWidget {
  final String eventName;
  final databaseReference = FirebaseDatabase.instance.reference();

  NotificationEventIcon(this.eventName);

  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: databaseReference
          .child("notifications/scheduled")
          .orderByChild("name")
          .equalTo(eventName)
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
                  "type": "eventSpecific",
                  "name": eventName,
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
