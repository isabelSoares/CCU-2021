import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'theme.dart';

class MuseumWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<dynamic> exhibitions = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Exhibitions"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
        stream: databaseReference.child("exhibitions").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            exhibitions = [];
            DataSnapshot dataValues = snapshot.data.snapshot;
            exhibitions = dataValues.value;

            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: exhibitions.length,
              itemBuilder: (context, index) =>
                  MuseumEventsListItem(exhibitions[index]),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class MuseumEventsListItem extends StatelessWidget {
  final museumEvent;

  MuseumEventsListItem(this.museumEvent);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(museumEvent["name"], style: myThemeData.textTheme.subtitle1),
      subtitle: Text(museumEvent["date"]),
      leading: Container(
        width: 100,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(museumEvent["image"]),
            fit: BoxFit.fill,
          ),
        ),
      ),
      enabled: true,
      /*onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GardenInfoWidget(musicEvent)));
        }*/
    );
  }
}
