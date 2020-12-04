import 'package:flutter/material.dart';
import 'dart:math';
import 'theme.dart';

Map<double, Color> capacityColors = {
  0.0: Color(0xFF70E75C),
  10.0: Color(0xFF70E75C),
  20.0: Color(0xFFB5F64B),
  30.0: Color(0xFFB5F64B),
  40.0: Color(0xFFF1E91F),
  50.0: Color(0xFFEF9935),
  60.0: Color(0xFFEF9935),
  70.0: Color(0xFFF45928),
  80.0: Color(0xFFF45928),
  90.0: Color(0xFFE40606),
  100.0: Color(0xFFE40606),
};

class CapacityInfoWidget extends StatelessWidget {
  final double capacity;

  CapacityInfoWidget(this.capacity);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.people, color: getCapacityColor(capacity)),
        SizedBox(width: 16),
        Text(capacity.round().toString() + " %",
            style: myThemeData.textTheme.caption),
      ],
    );
  }

  Color getCapacityColor(double capacity) {
    double lower = max(capacity - (capacity % 10), 0.0);
    double higher = min(lower + 10, 100.0);

    double frac = (capacity % 10) * 0.01;

    return Color.lerp(capacityColors[lower], capacityColors[higher], frac);
  }
}
