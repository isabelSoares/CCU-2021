import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'theme.dart';

class CafeMenuWidget extends StatelessWidget {
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    Map<dynamic, dynamic> menu = {};

    return Scaffold(
      appBar: AppBar(
        title: Text("Cafe Menu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: StreamBuilder(
          stream: databaseReference.child("places/cafe/menu").onValue,
          builder: (context, AsyncSnapshot<Event> snapshot) {
            if (snapshot.hasData) {
              DataSnapshot dataValues = snapshot.data.snapshot;
              Map<dynamic, dynamic> values = dataValues.value;
              values.forEach((key, value) {
                menu[key] = value;
              });

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SizedBox(width: 16),
                      Text("Food", style: myThemeData.textTheme.headline6),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: menu["food"].length,
                      itemBuilder: (context, index) =>
                          CafeMenuListItem(menu["food"][index]),
                    ),
                  ),
                  Row(
                    children: [
                      SizedBox(width: 16),
                      Text("Drinks", style: myThemeData.textTheme.headline6),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: menu["drinks"].length,
                      itemBuilder: (context, index) =>
                          CafeMenuListItem(menu["drinks"][index]),
                    ),
                  ),
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

class CafeMenuListItem extends StatelessWidget {
  final item;

  CafeMenuListItem(this.item);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item["name"], style: myThemeData.textTheme.subtitle1),
      subtitle: Text(item["price"]),
      enabled: true,
    );
  }
}
