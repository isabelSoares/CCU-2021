import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

class Place {
  String type;
  String name;
  String description;
  double capacity;
  TimeOfDay open;
  TimeOfDay close;
  String phoneNumber;
  String image;

  Place({
    this.type,
    this.name,
    this.description,
    this.capacity,
    this.open,
    this.close,
    this.phoneNumber,
    this.image,
  });

  String getOpeningString() {
    String formatTime(TimeOfDay time) {
      return formatDate(
              DateTime(2019, 08, 1, time.hour, time.minute), [HH, ':', nn])
          .toString();
    }

    return "Opened: " + formatTime(open) + " - " + formatTime(close);
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
    phoneNumber,
    image,
  }) : super(
          type: "Library",
          name: "Biblioteca de Arte",
          description: description,
          capacity: capacity,
          open: open,
          close: close,
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
    phoneNumber,
    image,
  }) : super(
          type: "Cafe",
          name: "Centro Interpretativo Gonçalo Ribeiro Telles",
          description: description,
          capacity: capacity,
          open: open,
          close: close,
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
    phoneNumber,
    image,
  }) : super(
          type: "Restaurant",
          name: "Cafetaria do Museu Gulbenkian",
          description: description,
          capacity: capacity,
          open: open,
          close: close,
          phoneNumber: phoneNumber,
          image: "lib/images/Restaurant.png",
        );
}

Library library = Library(
  capacity: 30.0,
  open: TimeOfDay(hour: 10, minute: 00),
  close: TimeOfDay(hour: 17, minute: 30),
  phoneNumber: "21 782 3000",
);

Cafe cafe = Cafe(
  capacity: 20.0,
  open: TimeOfDay(hour: 10, minute: 00),
  close: TimeOfDay(hour: 18, minute: 00),
  phoneNumber: "21 782 3000",
);

Restaurant restaurant = Restaurant(
  capacity: 50.0,
  open: TimeOfDay(hour: 10, minute: 00),
  close: TimeOfDay(hour: 18, minute: 00),
  phoneNumber: "21 782 3000",
);

List<Place> placesList = [
  library,
  cafe,
  restaurant,
];
