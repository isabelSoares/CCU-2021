import 'package:flutter/material.dart';
import 'dart:math';
import 'theme.dart';

Map<int, Color> capacityColors = {
  0: Color(0xFF70E75C),
  10: Color(0xFF70E75C),
  20: Color(0xFFB5F64B),
  30: Color(0xFFB5F64B),
  40: Color(0xFFF1E91F),
  50: Color(0xFFEF9935),
  60: Color(0xFFEF9935),
  70: Color(0xFFF45928),
  80: Color(0xFFF45928),
  90: Color(0xFFE40606),
  100: Color(0xFFE40606),
};

class CapacityInfoWidget extends StatelessWidget {
  final int capacity;

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

  Color getCapacityColor(int capacity) {
    int lower = max(capacity - (capacity % 10), 0);
    int higher = min(lower + 10, 100);

    double frac = (capacity % 10) * 0.01;

    return Color.lerp(capacityColors[lower], capacityColors[higher], frac);
  }
}
