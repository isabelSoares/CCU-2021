import 'package:flutter/material.dart';
import 'package:my_app/common/restaurantMenu.dart';
import 'theme.dart';

class RestaurantMenuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Restaurant Menu"),
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
              itemCount: restaurantMenuList.length,
              itemBuilder: (context, index) =>
                  RestaurantMenuListItem(restaurantMenuList[index]),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 16),
              Text("Drink", style: myThemeData.textTheme.headline6),
            ],
          ),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => Divider(),
              itemCount: restaurantMenuList.length,
              itemBuilder: (context, index) =>
                  RestaurantMenuListItem(restaurantMenuList[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantMenuListItem extends StatelessWidget {
  final RestaurantMenu restaurantMenu;

  RestaurantMenuListItem(this.restaurantMenu);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(restaurantMenu.name, style: myThemeData.textTheme.subtitle1),
      subtitle: Text(restaurantMenu.price),
      enabled: true,
    );
  }
}
