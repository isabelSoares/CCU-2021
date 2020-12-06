import 'package:flutter/material.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'package:my_app/common/musicEvent.dart';
import 'theme.dart';

class EventInfoWidget extends StatelessWidget {
  final MusicEvent event;

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
                  image: AssetImage(event.image),
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
                        child: Text(event.name,
                            style: myThemeData.textTheme.headline6),
                      ),
                      NotificationIcon(event.name),
                    ],
                  ),
                  SizedBox(height: 10),
                  event.description != null
                      ? Text(event.description,
                          style: myThemeData.textTheme.caption)
                      : Container(),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: myThemeData.primaryColor),
                      SizedBox(width: 16),
                      Text(event.date, style: myThemeData.textTheme.caption),
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
