import 'package:flutter/material.dart';
import 'home-grid-widget.dart';
import 'notifications-widget.dart';
import 'placeholder-widget.dart';
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
    HomeGridWidget(),
    PlaceholderWidget(Colors.green),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: primaryGreen,
          // unselectedLabelStyle: Theme.of(context).textTheme.caption,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
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
