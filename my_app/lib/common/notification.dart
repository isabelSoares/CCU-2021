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
  String description;
  NotificationType type;

  MyNotification({this.name, this.type, this.description = ""});

  String title() {
    return name;
  }

  String subtitle() {
    return description;
  }
}

class NotificationPlace extends MyNotification {
  TimeOfDay timeFrom;
  TimeOfDay timeTo;
  double capacity;

  NotificationPlace.basic(name)
      : super(name: name, type: NotificationType.PLACE) {
    this.timeFrom = TimeOfDay(hour: 9, minute: 00);
    this.timeTo = TimeOfDay(hour: 18, minute: 00);
    this.capacity = 50.0;
  }

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
  List<MyNotification> _notificationsReceived = [];

  bool _dontShowDialog = false;

  List<MyNotification> get notifications => _notifications;
  List<MyNotification> get notificationsReceived => _notificationsReceived;
  bool get dontShowDialog => _dontShowDialog;

  void add(MyNotification notification) {
    _notifications.add(notification);

    if (notification.name == "Library") {
      NotificationPlace placeNotification = notification as NotificationPlace;
      String capacity = placeNotification.capacity.round().toString();
      _notificationsReceived.add(
        MyNotification(
            name: "Library",
            description:
                "Currently it has a capacity lower than " + capacity + "%"),
      );
    }

    notifyListeners();
  }

  void remove(MyNotification notification) {
    _notifications.remove(notification);
    notifyListeners();
  }

  void removeReceived(MyNotification notification) {
    _notificationsReceived.remove(notification);
    notifyListeners();
  }

  int findNotification(String name) {
    var index = -1;

    for (int i = 0; i < _notifications.length; i++) {
      if (_notifications[i].name == name) {
        index = i;
      }
    }

    return index;
  }

  void togglePlaceNotification(String name) {
    int index = findNotification(name);

    if (index != -1) {
      _notifications.removeAt(index);
    } else {
      _notifications.add(NotificationPlace.basic(name));
    }

    notifyListeners();
  }

  bool hasNotification(String name) {
    return findNotification(name) != -1;
  }

  void addSpecificEventNotification(String name) {
    _notifications
        .add(MyNotification(name: name, type: NotificationType.EVENT));
    notifyListeners();
  }

  void toggleSpecificEventNotification(String name) {
    int index = findNotification(name);

    if (index != -1) {
      _notifications.removeAt(index);
    } else {
      addSpecificEventNotification(name);
    }

    notifyListeners();
  }

  void addDishNotification(String name, String description) {
    _notifications.add(MyNotification(
        name: name, description: description, type: NotificationType.DISH));
    notifyListeners();
  }

  void toggleDishNotification(String name) {
    int index = findNotification(name);

    if (index != -1) {
      _notifications.removeAt(index);
    } else {
      addSpecificEventNotification(name);
    }

    notifyListeners();
  }

  void setDontShowDialog(bool value) {
    _dontShowDialog = value;
    notifyListeners();
  }
}
