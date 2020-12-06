import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'dart:math';

class Place {
  String type;
  String name;
  String description;
  double capacity;
  Duration duration;
  int distance;
  TimeOfDay open;
  TimeOfDay close;
  String phoneNumber;
  String image;
  double lat;
  double long;

  Place({
    this.type,
    this.name,
    this.description,
    this.capacity,
    this.open,
    this.close,
    this.duration,
    this.distance,
    this.phoneNumber,
    this.image,
    this.lat = 38.736877563633065,
    this.long = -9.15316715580186,
  });

  String getOpeningString() {
    String formatTime(TimeOfDay time) {
      return formatDate(
              DateTime(2019, 08, 1, time.hour, time.minute), [HH, ':', nn])
          .toString();
    }

    return "Opened: " + formatTime(open) + " - " + formatTime(close);
  }

  String durationString() {
    return duration.inMinutes.toString() + " min";
  }

  String distanceString() {
    return distance.toString() + " m";
  }
}

class Library extends Place {
  Library({
    type,
    name,
    description,
    capacity,
    open,
    close,
    duration,
    distance,
    phoneNumber,
    image,
  }) : super(
          type: "Library",
          name: "Biblioteca de Arte",
          description: description,
          capacity: capacity,
          open: open,
          close: close,
          duration: duration,
          distance: distance,
          phoneNumber: phoneNumber,
          image: "./lib/images/Library.png",
        );
}

class Cafe extends Place {
  Cafe({
    type,
    name,
    description,
    capacity,
    open,
    close,
    duration,
    distance,
    phoneNumber,
    image,
  }) : super(
          type: "Cafe",
          name: "Centro Interpretativo Gonçalo Ribeiro Telles",
          description: description,
          capacity: capacity,
          open: open,
          close: close,
          duration: duration,
          distance: distance,
          phoneNumber: phoneNumber,
          image: "./lib/images/Cafe.png",
        );
}

class Restaurant extends Place {
  Restaurant({
    type,
    name,
    description,
    capacity,
    open,
    close,
    duration,
    distance,
    phoneNumber,
    image,
  }) : super(
          type: "Restaurant",
          name: "Cafetaria do Museu Gulbenkian",
          description: description,
          capacity: capacity,
          open: open,
          close: close,
          duration: duration,
          distance: distance,
          phoneNumber: phoneNumber,
          image: "lib/images/Restaurant.png",
        );
}

Library library = Library(
  capacity: Random().nextInt(100).toDouble(),
  open: TimeOfDay(hour: 10, minute: 00),
  close: TimeOfDay(hour: 17, minute: 30),
  duration: Duration(minutes: 5),
  distance: 200,
  phoneNumber: "21 782 3000",
);

Cafe cafe = Cafe(
  capacity: Random().nextInt(100).toDouble(),
  open: TimeOfDay(hour: 10, minute: 00),
  close: TimeOfDay(hour: 18, minute: 00),
  duration: Duration(minutes: 5),
  distance: 200,
  phoneNumber: "21 782 3000",
);

Restaurant restaurant = Restaurant(
  capacity: Random().nextInt(100).toDouble(),
  open: TimeOfDay(hour: 10, minute: 00),
  close: TimeOfDay(hour: 18, minute: 00),
  duration: Duration(minutes: 5),
  distance: 200,
  phoneNumber: "21 782 3000",
);

List<Place> placesList = [
  library,
  cafe,
  restaurant,
];
