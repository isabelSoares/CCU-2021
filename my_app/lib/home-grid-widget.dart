import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:my_app/gardens-widget.dart';
// import 'package:my_app/eat-widget.dart';
import 'package:my_app/library-widget.dart';
import 'package:my_app/museum-widget.dart';
import 'package:my_app/music-widget.dart';

class HomeGridWidget extends StatelessWidget {
  HomeGridWidget();

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      childAspectRatio: 156 / 117,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 2,
      children: <Widget>[
        MenuButtonWidget("Gardens"),
        MenuButtonWidget("Eat"),
        MenuButtonWidget("Museum"),
        MenuButtonWidget("Music"),
        MenuButtonWidget("Library"),
      ],
    );
  }
}

class MenuButtonWidget extends StatelessWidget {
  final String label;

  MenuButtonWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => getNavigation()));
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: FaIcon(
                    getIcon(),
                    size: 50,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(label),
                ),
              )
            ],
          ),
        ));
  }

  IconData getIcon() {
    switch (this.label) {
      case "Gardens":
        return FontAwesomeIcons.tree;
      case "Eat":
        return FontAwesomeIcons.coffee;
      case "Museum":
        return FontAwesomeIcons.university;
      case "Music":
        return FontAwesomeIcons.music;
      case "Library":
        return FontAwesomeIcons.book;
      default:
        return FontAwesomeIcons.cross;
    }
  }

  Widget getNavigation() {
    switch (this.label) {
      case "Gardens":
        return GardensWidget();
      case "Eat":
        return GardensWidget();
      // return EatWidget();
      case "Museum":
        return MuseumWidget();
      case "Music":
        return MusicWidget();
      case "Library":
        return LibraryWidget();
      default:
        return HomeGridWidget();
    }
  }
}
