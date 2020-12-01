import 'package:flutter/material.dart';
import 'theme.dart';

class RestaurantWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _RestaurantWidgetState();
  }
}

class _RestaurantWidgetState extends State<RestaurantWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: RestaurantInfoWidget("Restaurant", "50%"),
    );
  }
}

class RestaurantInfoWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  RestaurantInfoWidget(this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 360,
            height: 194,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/images/Restaurant.png'),
                fit : BoxFit.fill,
              )
            ),
          ),
          Text(title, style: myThemeData.textTheme.headline6),
          Text("Description", style: myThemeData.textTheme.caption),
          Divider(),
          Text("Capacity now:", style: myThemeData.textTheme.subtitle1),
          Text(subtitle, style: myThemeData.textTheme.caption),
          Divider(),
          Row(
            children: [
              Icon(Icons.access_time, color: myThemeData.primaryColor),
              Text("Opened 10am - 18pm", style: myThemeData.textTheme.caption),
            ],
          ),
          RaisedButton.icon(
            textColor: Color(0xFFFFFFFF),
            color: myThemeData.accentColor,
            label: Text("GO", style: myThemeData.textTheme.button),
            icon: Icon(Icons.near_me),
            onPressed: () {},
          ),
          RaisedButton.icon(
            textColor: Color(0xFFFFFFFF),
            color: myThemeData.accentColor,
            label: Text("MENU", style: myThemeData.textTheme.button),
            icon: Icon(Icons.local_restaurant),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
