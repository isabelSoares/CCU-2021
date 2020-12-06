import 'package:flutter/material.dart';
import 'package:my_app/common/places.dart';

class Garden extends Place {
  String name;
  String description;
  double capacity;
  Duration duration;
  int distance;
  String image;

  Garden({
    this.name,
    this.description,
    this.capacity,
    this.duration,
    this.distance = 200,
    this.image = "./lib/images/Garden São Sebastião.png",
  }) : super(
          type: name,
          name: name,
          description: description,
          capacity: capacity,
          open: TimeOfDay(hour: 8, minute: 00),
          close: TimeOfDay(hour: 19, minute: 0),
          phoneNumber: "",
          image: "./lib/images/Garden São Sebastião.png",
        );

  String durationString() {
    return duration.inMinutes.toString() + " min";
  }

  String distanceString() {
    return distance.toString() + " m";
  }
}

List<Garden> gardensList = [
  Garden(name: "Garden A", capacity: 20.0, duration: Duration(minutes: 5)),
  Garden(name: "Garden B", capacity: 30.0, duration: Duration(minutes: 5)),
  Garden(name: "Garden C", capacity: 50.0, duration: Duration(minutes: 5)),
];

Garden getGardenLowestCapacity() {
  int index = 0;
  double capacity = 100;

  for (int i = 0; i < gardensList.length; i++) {
    if (gardensList[i].capacity < capacity) {
      index = i;
      capacity = gardensList[i].capacity;
    }
  }

  return gardensList[index];
}
