import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'theme.dart';

class RouteMapWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _RouteMapWidgetState();
  }
}

class _RouteMapWidgetState extends State<RouteMapWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RouteMap"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RouteMapInfoWidget("RouteMap", "70%"),
    );
  }
}

class RouteMapInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  RouteMapInfoWidget(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 360,
            height: 380,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=38.73622228023147,-9.15344638918027&zoom=16.5&size=360x380&maptype=satellite&markers=color:red%7C38.736877563633065,-9.15316715580186&key=AIzaSyBzNhE2_nE7vzOIkb-QVIw3nr7CFaZW-YI'),
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      child: RaisedButton.icon(
                        textColor: Color(0xFFFFFFFF),
                        color: myThemeData.accentColor,
                        label: Text("X"),
                        icon: Icon(Icons.near_me),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 55),

                Column(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 8),
                    Text("5 min",
                        style: myThemeData.textTheme.caption),
                    SizedBox(height: 10),
                    Icon(Icons.phone, color: myThemeData.primaryColor),
                    SizedBox(width: 8),
                    Text("200 m", style: myThemeData.textTheme.caption),
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
