import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:my_app/home-screen-widget.dart';
import 'package:my_app/map-widget.dart';
import 'notifications-widget.dart';
import 'dart:math';
import 'theme.dart';

class HomeWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _HomeWidgetState();
  }
}

class _HomeWidgetState extends State<HomeWidget> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  int _currentIndex = 1;
  final List<Widget> _children = [
    NotificationsWidget(),
    HomeScreenWidget(),
    MapWidget(),
  ];

  @override
  void initState() {
    super.initState();
    updateCapacities();
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> notification) async {
      print("ON_MESSAGE");
      print("NOTIFICATION:" + notification.toString());
      DatabaseReference itemRef =
          databaseReference.child("notifications/received").push();
      itemRef.set({
        "type": notification["data"]["type"],
        "name": notification["data"]["name"],
        "description": notification["data"]["description"],
      });
    }, onLaunch: (Map<String, dynamic> notification) async {
      print("ON_LAUNCH");
      print("NOTIFICATION:" + notification.toString());
      DatabaseReference itemRef =
          databaseReference.child("notifications/received").push();
      itemRef.set({
        "type": notification["data"]["type"],
        "name": notification["data"]["name"],
        "description": notification["data"]["description"],
      });
    }, onResume: (Map<String, dynamic> notification) async {
      print("ON_RESUME");
      print("NOTIFICATION:" + notification.toString());
      DatabaseReference itemRef =
          databaseReference.child("notifications/received").push();
      itemRef.set({
        "type": notification["data"]["type"],
        "name": notification["data"]["name"],
        "description": notification["data"]["description"],
      });
    });
    _firebaseMessaging.requestNotificationPermissions();
  }

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

  void updateCapacities() {
    databaseReference
        .child("places/gardens/garden_north")
        .update({"capacity": Random().nextInt(100)});

    databaseReference
        .child("places/gardens/garden_south")
        .update({"capacity": Random().nextInt(100)});

    databaseReference
        .child("places/gardens/garden_east")
        .update({"capacity": Random().nextInt(100)});

    databaseReference
        .child("places/gardens/garden_west")
        .update({"capacity": Random().nextInt(100)});

    databaseReference
        .child("places/library")
        .update({"capacity": Random().nextInt(100)});

    databaseReference
        .child("places/cafe")
        .update({"capacity": Random().nextInt(100)});

    databaseReference
        .child("places/restaurant")
        .update({"capacity": Random().nextInt(100)});
  }
}
