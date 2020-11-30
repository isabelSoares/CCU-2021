import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/gardens-widget.dart';
import 'package:my_app/cafe-widget.dart';
import 'package:my_app/restaurant-widget.dart';

import 'theme.dart';

class CustomDrawerWidget extends StatelessWidget {
  CustomDrawerWidget();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: myThemeData.primaryColor),
            child: Text("LeavinGulbenkian"),
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.tree, size: 24),
            title: Text("Gardens"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GardensWidget()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.coffee, size: 24),
            title: Text("Cafe"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CafeWidget()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.utensils, size: 24),
            title: Text("Restaurant"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RestaurantWidget()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.university, size: 24),
            title: Text("Exhibitions"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GardensWidget()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.music, size: 24),
            title: Text("Events"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GardensWidget()));
            },
          ),
          ListTile(
            leading: FaIcon(FontAwesomeIcons.book, size: 24),
            title: Text("Library"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => GardensWidget()));
            },
          ),
        ],
      ),
    );
  }
}
