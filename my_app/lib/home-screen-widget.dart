import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_app/cafe-widget.dart';
import 'package:my_app/gardens-widget.dart';
import 'package:my_app/library-widget.dart';
import 'package:my_app/museum-widget.dart';
import 'package:my_app/music-widget.dart';
import 'package:my_app/restaurant-widget.dart';
import 'theme.dart';

class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Center(
            child: Container(
              // padding: EdgeInsets.all(16),
              child: Image.asset(
                './lib/images/Logo_Gulbenkian_no_background.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          MenuButton("Gardens", Color(0xFF3EA85C), FontAwesomeIcons.tree,
              GardensWidget()),
          MenuButton(
              "Cafe", Color(0xFF5CB272), FontAwesomeIcons.coffee, CafeWidget()),
          MenuButton("Restaurant", Color(0xFF78BD89), FontAwesomeIcons.utensils,
              RestaurantWidget()),
          MenuButton("Events", Color(0xFF9FCBAA), FontAwesomeIcons.music,
              MusicWidget()),
          MenuButton("Exhibitions", Color(0xFFC6DDCB),
              FontAwesomeIcons.university, MuseumWidget()),
          MenuButton("Library", Color(0xFFE6E8E7), FontAwesomeIcons.book,
              LibraryWidget()),
        ],
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final String title;
  final Color color;
  final IconData icon;
  final Widget navigation;

  MenuButton(this.title, this.color, this.icon, this.navigation);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => this.navigation));
      },
      enableFeedback: true,
      child: Container(
        decoration: BoxDecoration(
          color: this.color,
          borderRadius: BorderRadius.all(Radius.circular(6)),
          boxShadow: [
            BoxShadow(
              color: Color(0x44000000),
              blurRadius: 2.0,
              spreadRadius: 0.0,
              offset: Offset(2.0, 2.0),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 60,
              width: 60,
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: FaIcon(
                  this.icon,
                  size: 40,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(this.title, style: myThemeData.textTheme.headline5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
