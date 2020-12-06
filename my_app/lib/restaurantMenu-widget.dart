import 'package:flutter/material.dart';
import 'package:my_app/common/notification.dart';
import 'package:my_app/common/restaurantMenu.dart';
import 'package:provider/provider.dart';
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
              itemCount: restaurantFoodMenuList.length,
              itemBuilder: (context, index) =>
                  RestaurantMenuListItem(restaurantFoodMenuList[index], true),
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
              itemCount: restaurantDrinksMenuList.length,
              itemBuilder: (context, index) => RestaurantMenuListItem(
                  restaurantDrinksMenuList[index], false),
            ),
          ),
        ],
      ),
    );
  }
}

class RestaurantMenuListItem extends StatelessWidget {
  final RestaurantMenu restaurantMenu;
  final bool hasNotification;

  RestaurantMenuListItem(this.restaurantMenu, this.hasNotification);

  @override
  Widget build(BuildContext context) {
    return hasNotification
        ? ListTile(
            title: Text(restaurantMenu.name,
                style: myThemeData.textTheme.subtitle1),
            subtitle: Text(restaurantMenu.price),
            enabled: true,
            trailing: NotificationDishIcon(restaurantMenu),
          )
        : ListTile(
            title: Text(restaurantMenu.name,
                style: myThemeData.textTheme.subtitle1),
            subtitle: Text(restaurantMenu.price),
            enabled: true,
            trailing: NotificationDishIcon(restaurantMenu),
          );
  }
}

class NotificationDishIcon extends StatelessWidget {
  final RestaurantMenu restaurantMenu;

  NotificationDishIcon(this.restaurantMenu);

  @override
  Widget build(BuildContext context) {
    var manager = context.watch<NotificationManager>();
    bool hasNotification = manager.hasNotification(restaurantMenu.name);

    return hasNotification
        ? IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              manager.toggleDishNotification(restaurantMenu.name);
            },
          )
        : IconButton(
            icon: Icon(Icons.notifications_none),
            onPressed: () {
              manager.toggleDishNotification(restaurantMenu.name);
            },
          );
  }
}
