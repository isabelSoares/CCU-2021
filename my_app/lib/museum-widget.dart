import 'package:flutter/material.dart';
import 'package:my_app/common/museumEvent.dart';
import 'theme.dart';

class MuseumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: museumEventsList.length,
        itemBuilder: (context, index) =>
            MuseumEventsListItem(museumEventsList[index]),
      ),
    );
  }
}

class MuseumEventsListItem extends StatelessWidget {
  final MuseumEvent museumEvent;

  MuseumEventsListItem(this.museumEvent);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(museumEvent.name, style: myThemeData.textTheme.subtitle1),
      subtitle: Text(museumEvent.date),
      leading: Container(
        width: 100,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(museumEvent.image),
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
