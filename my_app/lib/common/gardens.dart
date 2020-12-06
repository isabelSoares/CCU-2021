import 'package:flutter/material.dart';
import 'package:my_app/common/places.dart';
import 'dart:math';

class Garden extends Place {
  String name;
  String description;
  double capacity;
  Duration duration;
  int distance;
  String image;
  double lat;
  double long;

  Garden({
    this.name,
    this.description,
    this.capacity,
    this.duration,
    this.distance = 200,
    this.image,
    this.lat,
    this.long,
  }) : super(
          type: name,
          name: name,
          description: description,
          capacity: capacity,
          open: TimeOfDay(hour: 8, minute: 00),
          close: TimeOfDay(hour: 19, minute: 0),
          phoneNumber: "",
          image: image,
          lat: lat,
          long: long,
        );
}

List<Garden> gardensList = [
  Garden(
    name: "Garden North",
    capacity: Random().nextInt(100).toDouble(),
    duration: Duration(minutes: 5),
    image: "./lib/images/Garden Praça de Espanha.png",
    lat: 38.73755353858259,
    long: -9.15538987149227,
  ),
  Garden(
    name: "Garden East",
    capacity: Random().nextInt(100).toDouble(),
    duration: Duration(minutes: 5),
    image: "./lib/images/Garden Praça de Espanha.png",
    lat: 38.7362625697443,
    long: -9.154970794626974,
  ),
  Garden(
    name: "Garden South",
    capacity: Random().nextInt(100).toDouble(),
    duration: Duration(minutes: 5),
    image: "./lib/images/Garden São Sebastião.png",
    lat: 38.73542567859379,
    long: -9.15286794296053,
  ),
  Garden(
    name: "Garden West",
    capacity: Random().nextInt(100).toDouble(),
    duration: Duration(minutes: 5),
    image: "./lib/images/Garden Praça de Espanha.png",
    lat: 38.736689380455296,
    long: -9.1526962816,
  ),
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
