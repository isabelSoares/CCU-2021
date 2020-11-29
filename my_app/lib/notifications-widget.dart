import 'package:flutter/material.dart';
import 'package:my_app/custom-drawer-widget.dart';

class NotificationsWidget extends StatefulWidget {
  State<StatefulWidget> createState() {
    return _NotificationsWidgetState();
  }
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Notifications"),
            bottom: TabBar(
              isScrollable: true,
              tabs: [
                Tab(text: "All"),
                Tab(text: "Places"),
                Tab(text: "Dishes"),
                Tab(text: "Events"),
                Tab(text: "Exhibitions"),
              ],
            ),
          ),
          drawer: CustomDrawerWidget(),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
              Icon(Icons.directions_bike),
              Icon(Icons.directions_boat),
              Icon(Icons.directions_bus),
            ],
          ),
        ));
  }
}
