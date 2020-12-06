import 'package:flutter/material.dart';
import 'package:my_app/common/musicEvent.dart';
import 'package:my_app/music-event-widget.dart';
import 'package:my_app/new-event-notification-widget.dart';
import 'theme.dart';

class MusicWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: musicEventsList.length,
        itemBuilder: (context, index) =>
            MusicEventsListItem(musicEventsList[index]),
      ),
    );
  }
}

class MusicEventsListItem extends StatelessWidget {
  final MusicEvent musicEvent;

  MusicEventsListItem(this.musicEvent);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(musicEvent.name, style: myThemeData.textTheme.subtitle1),
      subtitle: Text(musicEvent.date),
      leading: Container(
        width: 100,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(musicEvent.image),
            fit: BoxFit.fill,
          ),
        ),
      ),
      enabled: true,
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EventInfoWidget(musicEvent)));
      },
    );
  }
}
