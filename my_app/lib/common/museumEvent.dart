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
      name: "Exhibition A",
      date: "09 Jan - 14 Jan",
      image: "./lib/images/Garden São Sebastião.png"),
  MuseumEvent(
      name: "Exhibition B",
      date: "10 Jan - 15 Jan",
      image: "./lib/images/Garden São Sebastião.png"),
  MuseumEvent(
      name: "Exhibition C",
      date: "11 Jan - 16 Jan",
      image: "./lib/images/Garden São Sebastião.png"),
];
