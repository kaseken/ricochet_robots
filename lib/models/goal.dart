import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/robot.dart';

enum GoalTypes {
  star,
  planet,
  sun,
  moon,
}

IconData getIcon(GoalTypes type) {
  switch (type) {
    case GoalTypes.star:
      return Icons.star;
    case GoalTypes.sun:
      return Icons.wb_sunny;
    case GoalTypes.moon:
      return Icons.nightlight_round;
    case GoalTypes.planet:
      return Icons.language;
    default:
      return Icons.help;
  }
}

class Goal {
  final bool isWild;
  final RobotColors color;
  final GoalTypes type;

  const Goal({
    required this.isWild,
    required this.color,
    required this.type,
  });
}
