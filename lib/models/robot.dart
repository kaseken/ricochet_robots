import 'package:flutter/material.dart';

enum RobotColors {
  red,
  blue,
  green,
  yellow,
}

Color getActualColor(RobotColors color) {
  switch (color) {
    case RobotColors.red:
      return Colors.red;
    case RobotColors.blue:
      return Colors.blue;
    case RobotColors.green:
      return Colors.green;
    case RobotColors.yellow:
      return Colors.amber;
    default:
      return Colors.transparent;
  }
}

class Robot {
  final RobotColors color;

  const Robot({
    required this.color,
  });
}
