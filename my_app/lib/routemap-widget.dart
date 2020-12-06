import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_app/common/places.dart';
import 'theme.dart';

class RouteMapWidget extends StatelessWidget {
  final Place place;

  RouteMapWidget(this.place);

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
      body: RouteMapInfoWidget(place),
    );
  }
}

class RouteMapInfoWidget extends StatelessWidget {
  final Place place;

  RouteMapInfoWidget(this.place);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            // width: 360,
            height: 410,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    'https://maps.googleapis.com/maps/api/staticmap?center=38.73622228023147,-9.15344638918027&zoom=16.5&size=360x380&maptype=satellite&markers=color:red%7C38.736877563633065,-9.15316715580186&key=AIzaSyBzNhE2_nE7vzOIkb-QVIw3nr7CFaZW-YI'),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Color(0xFFE40606),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: IconButton(
                        icon: Icon(Icons.close),
                        iconSize: 30,
                        color: Color(0xFFE40606),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 55),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(children: [
                      Icon(Icons.access_time,
                          size: 30, color: myThemeData.primaryColor),
                      SizedBox(width: 16),
                      Text("5 min", style: myThemeData.textTheme.headline6),
                    ]),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.directions_run,
                            size: 30, color: myThemeData.primaryColor),
                        SizedBox(width: 16),
                        Text("200 m", style: myThemeData.textTheme.subtitle1),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
