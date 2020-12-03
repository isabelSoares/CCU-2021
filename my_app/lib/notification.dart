import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/foundation.dart';

enum NotificationType {
  PLACE,
  DISH,
  EVENT,
  EXHIBITION,
}

enum EventType {
  ORQUESTRAL,
  CHAMBER,
  CHORAL,
  CINEMA,
  CONTEMPORARY,
  EARLY_AND_BARROQUE,
  JAZZ,
  OPERA,
  PIANO,
  VOICE,
  VIOLIN,
  WORLD_MUSIC,
}

String getEventType(EventType event) {
  switch (event) {
    case EventType.ORQUESTRAL:
      return "Orquestral";
    case EventType.CHAMBER:
      return "Chamber";
    case EventType.CHORAL:
      return "Choral";
    case EventType.CINEMA:
      return "Cinema";
    case EventType.CONTEMPORARY:
      return "Contemporary";
    case EventType.EARLY_AND_BARROQUE:
      return "Early and Barroque";
    case EventType.JAZZ:
      return "Jazz";
    case EventType.OPERA:
      return "Opera";
    case EventType.PIANO:
      return "Piano";
    case EventType.VOICE:
      return "Voice";
    case EventType.VIOLIN:
      return "Violin";
    case EventType.WORLD_MUSIC:
      return "World Music";
    default:
      return "Unknown event type";
  }
}

Map<String, Duration> timeFrameMap = {
  "a day before": Duration(days: 1),
  "two days before": Duration(days: 2),
  "a week before": Duration(days: 7),
  "two weeks before": Duration(days: 14),
  "a month before": Duration(days: 30),
  "two months before": Duration(days: 60)
};

String getTimeFrameString(Duration timeFrame) {
  return timeFrameMap.keys
      .firstWhere((element) => timeFrameMap[element] == timeFrame);
}

class MyNotification {
  String name;
  NotificationType type;

  MyNotification({this.name, this.type});

  String title() {
    return "TITLE SUPER";
  }

  String subtitle() {
    return "SUBTITLE SUPER";
  }
}

class NotificationPlace extends MyNotification {
  TimeOfDay timeFrom;
  TimeOfDay timeTo;
  double capacity;

  NotificationPlace(name, this.timeFrom, this.timeTo, this.capacity)
      : super(name: name, type: NotificationType.PLACE);

  String title() {
    return this.name;
  }

  String subtitle() {
    String formatTime(TimeOfDay time) {
      return formatDate(
              DateTime(2019, 08, 1, time.hour, time.minute), [HH, ':', nn])
          .toString();
    }

    return formatTime(timeFrom) +
        " - " +
        formatTime(timeTo) +
        ", capacity less than " +
        capacity.round().toString() +
        "%";
  }
}

class NotificationEvent extends MyNotification {
  EventType eventType;
  Duration timeFrame;

  String title() {
    return getEventType(eventType) + " events";
  }

  String subtitle() {
    return "a week before";
  }

  NotificationEvent(name, this.eventType, this.timeFrame)
      : super(name: name, type: NotificationType.EVENT);
}

class NotificationManager extends ChangeNotifier {
  List<MyNotification> _notifications = [];

  List<MyNotification> get notifications => _notifications;

  void add(MyNotification notification) {
    _notifications.add(notification);
    notifyListeners();
  }

  void remove(MyNotification notification) {
    _notifications.remove(notification);
    notifyListeners();
  }
}

// SINGLETON NOTIFICATION MANAGER
// class NotificationManager {
//   static final NotificationManager _instance = NotificationManager._internal();

//   List<MyNotification> notifications = [];

//   factory NotificationManager() {
//     return _instance;
//   }

//   NotificationManager._internal();

//   static NotificationManager get manager {
//     return _instance;
//   }

//   void addNotification(MyNotification notification) {
//     notifications.add(notification);
//   }

//   void removeNotification(MyNotification notification) {
//     notifications.remove(notification);
//   }
// }
