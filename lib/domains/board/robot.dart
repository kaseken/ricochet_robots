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
      return Colors.black;
  }
}

class Robot {
  final RobotColors color;

  const Robot({
    required this.color,
  });

  static Robot get red => const Robot(color: RobotColors.red);
  static Robot get blue => const Robot(color: RobotColors.blue);
  static Robot get green => const Robot(color: RobotColors.green);
  static Robot get yellow => const Robot(color: RobotColors.yellow);
}
