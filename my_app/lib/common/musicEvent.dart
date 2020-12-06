class MusicEvent {
  String name;
  String description;
  String date;
  String image;

  MusicEvent({
    this.name,
    this.description,
    this.date,
    this.image,
  });
}

List<MusicEvent> musicEventsList = [
  MusicEvent(
      name: "Nikolai Lugansky",
      date: "09 Jan - 14 Jan",
      image: "./lib/images/piano1.png"),
  MusicEvent(
      name: "Seong-Jin Cho",
      date: "10 Jan - 15 Jan",
      image: "./lib/images/piano2.png"),
  MusicEvent(
      name: "Arcadi Volodos",
      date: "11 Jan - 16 Jan",
      image: "./lib/images/piano3.png"),
];
