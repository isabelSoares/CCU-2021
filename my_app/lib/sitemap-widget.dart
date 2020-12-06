import 'package:flutter/material.dart';
import 'package:my_app/routemap-widget.dart';
import 'theme.dart';

class SiteMapWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _SiteMapWidgetState();
  }
}

class _SiteMapWidgetState extends State<SiteMapWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SiteMap"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SiteMapInfoWidget("SiteMap", "70%"),
    );
  }
}

class SiteMapInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  SiteMapInfoWidget(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: 360,
            height: 325,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=38.73622228023147,-9.15344638918027&zoom=16.5&size=360x325&maptype=satellite&markers=color:red%7C38.736877563633065,-9.15316715580186&key=AIzaSyBzNhE2_nE7vzOIkb-QVIw3nr7CFaZW-YI'),
              fit: BoxFit.fill,
            )),
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 8),
                    Text(title,
                        style: myThemeData.textTheme.caption),
                  ],
                ),
                SizedBox(height: 10),

                Row(
                  children: [
                    Icon(Icons.access_time, color: myThemeData.primaryColor),
                    SizedBox(width: 8),
                    Text("5 min",
                        style: myThemeData.textTheme.caption),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.phone, color: myThemeData.primaryColor),
                    SizedBox(width: 8),
                    Text("200 m", style: myThemeData.textTheme.caption),
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
                  textColor: Color(0xFFFFFFFF),
                  color: myThemeData.accentColor,
                  label: Text("START"),
                  icon: Icon(Icons.near_me),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => RouteMapWidget()));
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
