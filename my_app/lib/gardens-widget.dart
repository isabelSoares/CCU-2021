import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/capacity-info-widget.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'package:my_app/sitemap-widget.dart';
import 'package:my_app/common/string-utils.dart';
import 'theme.dart';

class GardensWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    List<dynamic> gardens = [];

    return Scaffold(
      appBar: AppBar(
        title: Text("Gardens"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.lightbulb),
            onPressed: () {
              showDialog(
                  context: context, builder: (_) => GardenSpotFoundDialog());
            },
          ),
        ],
      ),
      body: StreamBuilder(
        stream: databaseReference.child("places/gardens").onValue,
        builder: (context, AsyncSnapshot<Event> snapshot) {
          if (snapshot.hasData) {
            gardens.clear();
            DataSnapshot dataValues = snapshot.data.snapshot;
            Map<dynamic, dynamic> values = dataValues.value;
            values.forEach((key, value) {
              gardens.add(value);
            });
            return ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: gardens.length,
              itemBuilder: (context, index) => GardenListItem(gardens[index]),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class GardenSpotFoundDialog extends StatelessWidget {
  GardenSpotFoundDialog();

  @override
  Widget build(BuildContext context) {
    final databaseReference = FirebaseDatabase.instance.reference();

    var garden;

    return AlertDialog(
      title: Text("Spot found"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Looks like this garden has low capacity."),
          SizedBox(height: 16),
          StreamBuilder(
            stream: databaseReference
                .child("places/gardens")
                .orderByChild("capacity")
                .limitToFirst(1)
                .onValue,
            builder: (context, AsyncSnapshot<Event> snapshot) {
              if (snapshot.hasData) {
                DataSnapshot dataValues = snapshot.data.snapshot;
                Map<dynamic, dynamic> values = dataValues.value;
                values.forEach((key, value) {
                  garden = value;
                });
                print("GARDEN: " + garden.toString());
                return GardenListItem(garden);
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
      actions: [
        RaisedButton(
          textColor: Colors.white,
          child: Text("CLOSE"),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        RaisedButton.icon(
          textColor: Colors.white,
          label: Text("GO"),
          icon: Icon(Icons.near_me),
          onPressed: () {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SiteMapWidget(garden)));
          },
        ),
      ],
    );
  }
}

class GardenListItem extends StatelessWidget {
  final garden;

  GardenListItem(this.garden);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(garden["name"], style: myThemeData.textTheme.subtitle1),
      subtitle: CapacityInfoWidget(garden["capacity"]),
      leading: Container(
        width: 100,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(garden["image"]),
            fit: BoxFit.fill,
          ),
        ),
      ),
      enabled: true,
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => GardenInfoWidget(garden)));
      },
    );
  }
}

class GardenInfoWidget extends StatelessWidget {
  final garden;

  GardenInfoWidget(this.garden);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(garden["name"]),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              // width: 360,
              height: 194,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(garden["image"]),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(garden["name"],
                            style: myThemeData.textTheme.headline6),
                      ),
                      NotificationIcon(garden["name"].toString()),
                    ],
                  ),
                  SizedBox(height: 10),
                  garden["description"] != null
                      ? Text(garden["description"],
                          style: myThemeData.textTheme.caption)
                      : Container(),
                  Divider(),
                  SizedBox(height: 10),
                  Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                  SizedBox(height: 10),
                  CapacityInfoWidget(garden["capacity"]),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: myThemeData.primaryColor),
                      SizedBox(width: 16),
                      Text(getDurationString(garden["duration"]),
                          style: myThemeData.textTheme.caption),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.directions_run,
                          color: myThemeData.primaryColor),
                      SizedBox(width: 16),
                      Text(getDistanceString(garden["distance"]),
                          style: myThemeData.textTheme.caption),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  padding: EdgeInsets.all(16),
                  child: RaisedButton.icon(
                    textColor: Colors.white,
                    label: Text("GO"),
                    icon: Icon(Icons.near_me),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SiteMapWidget(garden)));
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
