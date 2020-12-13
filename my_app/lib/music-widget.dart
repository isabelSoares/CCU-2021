import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/music-event-widget.dart';
import 'package:my_app/new-event-notification-widget.dart';
import 'theme.dart';

class MusicWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<dynamic> events = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Music"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NewTypeEventNotificationWidget()));
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: databaseReference.child("events").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            events = [];
            DataSnapshot dataValues = snapshot.data.snapshot;
            events = dataValues.value;

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: events.length,
              itemBuilder: (context, index) =>
                  MusicEventsListItem(events[index]),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MusicEventsListItem extends StatelessWidget {
  final event;

  MusicEventsListItem(this.event);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(event["name"], style: myThemeData.textTheme.subtitle1),
      subtitle: Text(event["date"]),
      leading: Container(
        width: 100,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(event["image"]),
            fit: BoxFit.fill,
          ),
        ),
      ),
      enabled: true,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EventInfoWidget(event)));
      },
    );
  }
}
