import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class EatGridWidget extends StatefulWidget {
  EatGridWidget();

  State<StatefulWidget> createState() {
    return GridView.count(
      primary: false,
      childAspectRatio: 125 / 53,
      padding: const EdgeInsets.all(20),
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      crossAxisCount: 2,
      children: <Widget>[
        EatButtonWidget("Cafe"),
        EatButtonWidget("Restaurant"),
      ],
    );
  }
}

class EatWidgetState extends State<EatGridWidget> {
  final String label;

  EatButtonWidget(this.label);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      appBar: AppBar(
        title: const Text("Eat"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
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
        ))
        ),
      );
}
   

IconData getIcon() {
    switch (this.label) {
      case "Cafe":
        return FontAwesomeIcons.coffee;
      case "Restaurant":
        return FontAwesomeIcons.utensils;
      default:
        return FontAwesomeIcons.cross;
    }
  }

Widget getNavigation() {
    switch (this.label) {
      case "Cafe":
        return CafeWidget();
      case "Restaurant":
        return RestaurantWidget();
      default:
        return EatGridWidget();
    }
  }
}
