import 'package:flutter/material.dart';
import 'theme.dart';

class GardensWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _GardensWidgetState();
  }
}

class _GardensWidgetState extends State<GardensWidget> {
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
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          GardenListItem("Garden A", "10%"),
          Divider(),
          GardenListItem("Garden B", "30%"),
          Divider(),
          GardenListItem("Garden C", "50%"),
          Divider(),
        ],
      ),
    );
  }
}

class GardenListItem extends StatelessWidget {
  final String title;
  final String subtitle;

  GardenListItem(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        title: Text(title, style: myThemeData.textTheme.subtitle1),
        subtitle: Text(subtitle, style: myThemeData.textTheme.caption),
        leading: Container(
          width: 100,
          height: 56,
          color: Color(0xFFB9DCA9),
        ),
        enabled: true,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => GardenInfoWidget(title, subtitle)));
        });
  }
}

class GardenInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  GardenInfoWidget(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
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
              width: 360,
              height: 194,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('./lib/images/Garden São Sebastião.png'),
                  fit: BoxFit.fill,
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
                        child:
                            Text(title, style: myThemeData.textTheme.headline6),
                      ),
                      Icon(Icons.notifications_none)
                    ],
                  ),
                  SizedBox(height: 10),
                  Text("Description", style: myThemeData.textTheme.caption),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
                  Text(subtitle, style: myThemeData.textTheme.caption),
                  SizedBox(height: 10),
                  Divider(),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.access_time, color: myThemeData.primaryColor),
                      SizedBox(width: 8),
                      Text("5 min", style: myThemeData.textTheme.caption),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.directions_run,
                          color: myThemeData.primaryColor),
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
                    label: Text("GO"),
                    icon: Icon(Icons.near_me),
                    onPressed: () {},
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

// Expanded(
//                       child: Align(
//                         alignment: Alignment.bottomRight,
//                         child: RaisedButton.icon(
//                           textColor: Color(0xFFFFFFFF),
//                           color: myThemeData.accentColor,
//                           label:
//                               Text("GO", style: myThemeData.textTheme.button),
//                           icon: Icon(Icons.near_me),
//                           onPressed: () {},
//                         ),
//                       ),
//                     ),
