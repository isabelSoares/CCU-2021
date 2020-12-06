class MusicEvent {
  String name;
  String date;
  String image;

  MusicEvent({
    this.name,
    this.date,
    this.image,
  });
}

List<MusicEvent> musicEventsList = [
  MusicEvent(
      name: "Music Event A",
      date: "09 Jan - 14 Jan",
      image: "./lib/images/Garden São Sebastião.png"),
  MusicEvent(
      name: "Music Event B",
      date: "10 Jan - 15 Jan",
      image: "./lib/images/Garden São Sebastião.png"),
  MusicEvent(
      name: "Music Event C",
      date: "11 Jan - 16 Jan",
      image: "./lib/images/Garden São Sebastião.png"),
];
