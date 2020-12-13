import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

String formatTime(TimeOfDay time) {
  return formatDate(
      DateTime(2019, 08, 1, time.hour, time.minute), [HH, ':', nn]).toString();
}

String getOpeningString(
    int hourOpen, int minuteOpen, int hourClose, int minuteClose) {
  return "Opened: " +
      formatTime(TimeOfDay(hour: hourOpen, minute: minuteOpen)) +
      " - " +
      formatTime(TimeOfDay(hour: hourClose, minute: minuteClose));
}

String getDistanceString(int distance) {
  return distance.toString() + " m";
}

String getDurationString(int minute) {
  return minute.toString() + " min";
}

String getTimeFrameString(int days) {
  if (days == 1) {
    return "a day before";
  } else if (days == 2) {
    return "two days before";
  } else if (days == 7) {
    return "a week before";
  } else if (days == 14) {
    return "two weeks before";
  } else if (days == 30) {
    return "a month before";
  } else if (days == 60) {
    return "two months before";
  } else {
    return "";
  }
}

String getNotificationPlaceTitle(String name) {
  return name;
}

String getNotificationPlaceSubtitle(
    int hourFrom, int minuteFrom, int hourTo, int minuteTo, int capacity) {
  return formatTime(TimeOfDay(hour: hourFrom, minute: minuteFrom)) +
      " - " +
      formatTime(TimeOfDay(hour: hourTo, minute: minuteTo)) +
      ", capacity less than " +
      capacity.toString() +
      "%";
}

String getNotificationEventTitle(String type) {
  return type + " events";
}

String getNotificationEventSubtitle(int days) {
  return getTimeFrameString(days);
}

String getNotificationEventSpecificTitle(String name) {
  return name;
}

String getNotificationDishTitle(String name) {
  return name;
}

String getNotificationDishSubtitle(String price) {
  return price;
}
