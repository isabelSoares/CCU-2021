import 'package:flutter/material.dart';
import 'package:my_app/routemap-widget.dart';
import 'package:my_app/common/places.dart';
import 'theme.dart';

class SiteMapWidget extends StatelessWidget {
  final Place place;

  SiteMapWidget(this.place);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(place.type),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SiteMapInfoWidget(place),
    );
  }
}

class SiteMapInfoWidget extends StatelessWidget {
  final Place place;

  SiteMapInfoWidget(this.place);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            // width: 360,
            height: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://maps.googleapis.com/maps/api/staticmap?center=38.73622228023147,-9.15344638918027&zoom=16.5&size=360x325&maptype=satellite&markers=color:red%7C38.736877563633065,-9.15316715580186&key=AIzaSyBzNhE2_nE7vzOIkb-QVIw3nr7CFaZW-YI'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_on, color: myThemeData.primaryColor),
                      SizedBox(width: 8),
                      Text(place.name, style: myThemeData.textTheme.bodyText1),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: myThemeData.primaryColor),
                      SizedBox(width: 8),
                      Text(place.durationString(),
                          style: myThemeData.textTheme.bodyText1),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.directions_run,
                          color: myThemeData.primaryColor),
                      SizedBox(width: 8),
                      Text(place.distanceString(),
                          style: myThemeData.textTheme.bodyText1),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.all(16),
                child: RaisedButton.icon(
                  textColor: Color(0xFFFFFFFF),
                  color: myThemeData.accentColor,
                  label: Text("START"),
                  icon: Icon(Icons.near_me),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RouteMapWidget(place)));
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
