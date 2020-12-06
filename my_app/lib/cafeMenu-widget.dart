import 'package:flutter/material.dart';
import 'package:my_app/common/restaurantMenu.dart';
import 'theme.dart';

class CafeMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cafe Menu"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
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
              itemCount: cafeFoodMenuList.length,
              itemBuilder: (context, index) =>
                  CafeMenuListItem(cafeFoodMenuList[index]),
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
              itemCount: cafeDrinksMenuList.length,
              itemBuilder: (context, index) =>
                  CafeMenuListItem(cafeDrinksMenuList[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class CafeMenuListItem extends StatelessWidget {
  final RestaurantMenu cafeMenu;

  CafeMenuListItem(this.cafeMenu);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(cafeMenu.name, style: myThemeData.textTheme.subtitle1),
      subtitle: Text(cafeMenu.price),
      enabled: true,
    );
  }
}
