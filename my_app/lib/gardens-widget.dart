import 'package:flutter/material.dart';
import 'package:my_app/capacity-info-widget.dart';
import 'package:my_app/notification-icon-widget.dart';
import 'package:my_app/common/gardens.dart';
import 'package:my_app/sitemap-widget.dart';
import 'theme.dart';

class GardensWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(),
        itemCount: gardensList.length,
        itemBuilder: (context, index) => GardenListItem(gardensList[index]),
      ),
    );
  }
}

class GardenSpotFoundDialog extends StatelessWidget {
  GardenSpotFoundDialog();

  @override
  Widget build(BuildContext context) {
    Garden garden = getGardenLowestCapacity();

    return AlertDialog(
      title: Text("Spot found"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Looks like this garden has low capacity."),
          SizedBox(height: 16),
          GardenListItem(garden),
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
          },
        ),
      ],
    );
  }
}

class GardenListItem extends StatelessWidget {
  final Garden garden;

  GardenListItem(this.garden);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(garden.name, style: myThemeData.textTheme.subtitle1),
      subtitle: CapacityInfoWidget(garden.capacity),
      leading: Container(
        width: 100,
        height: 56,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(garden.image),
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
  final Garden garden;

  GardenInfoWidget(this.garden);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(garden.name),
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
                  image: AssetImage(garden.image),
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
                        child: Text(garden.name,
                            style: myThemeData.textTheme.headline6),
                      ),
                      NotificationIcon(garden.name),
                    ],
                  ),
                  SizedBox(height: 10),
                  garden.description != null
                      ? Text(garden.description,
                          style: myThemeData.textTheme.caption)
                      : Container(),
                  Divider(),
                  SizedBox(height: 10),
                  Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                  SizedBox(height: 10),
                  CapacityInfoWidget(garden.capacity),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: myThemeData.primaryColor),
                      SizedBox(width: 16),
                      Text(garden.durationString(),
                          style: myThemeData.textTheme.caption),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.directions_run,
                          color: myThemeData.primaryColor),
                      SizedBox(width: 16),
                      Text(garden.distanceString(),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context) => SiteMapWidget(garden)));
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
