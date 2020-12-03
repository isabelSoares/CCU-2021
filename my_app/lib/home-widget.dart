import 'package:flutter/material.dart';
import 'package:my_app/map-widget.dart';
import 'for-today-widget.dart';
import 'notifications-widget.dart';
import 'theme.dart';

class HomeWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {
  int _currentIndex = 1;
  final List<Widget> _children = [
    NotificationsWidget(),
    ForTodayWidget(),
    MapWidget(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: _currentIndex,
          iconSize: 24.0,
          onTap: onTabTapped,
          selectedLabelStyle: myThemeData.textTheme.caption,
          selectedItemColor: Color(0xFFFFFFFF),
          unselectedLabelStyle: myThemeData.textTheme.caption,
          unselectedItemColor: Color(0x77FFFFFF),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              label: 'Map',
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
