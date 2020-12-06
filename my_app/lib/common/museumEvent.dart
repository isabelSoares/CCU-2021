class MuseumEvent {
  String name;
  String date;
  String image;

  MuseumEvent({
    this.name,
    this.date,
    this.image,
  });
}

List<MuseumEvent> museumEventsList = [
  MuseumEvent(
      name: "Age of Glass: Art and Industry",
      date: "09 Jan - 14 Jan",
      image: "./lib/images/art1.png"),
  MuseumEvent(
      name: "Infinite Sculpture From the Antique Cast to the 3D Scan",
      date: "10 Jan - 15 Jan",
      image: "./lib/images/art2.png"),
  MuseumEvent(
      name: "Art on Display: 1949-69",
      date: "11 Jan - 16 Jan",
      image: "./lib/images/art3.png"),
];
