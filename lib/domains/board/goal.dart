import 'dart:math';

import 'package:flutter/material.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

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
  final RobotColors? color;
  final GoalTypes? type;

  const Goal({
    this.color,
    this.type,
  });
}

class GoalBuilder {
  static Goal build() {
    final n = Random().nextInt(17);
    if (n == 0) {
      return const Goal();
    }
    return Goal(color: _buildColor(n), type: _buildType(n));
  }

  static RobotColors _buildColor(int n) {
    assert(1 <= n && n <= 16);
    if (n <= 4) {
      return RobotColors.red;
    }
    if (n <= 8) {
      return RobotColors.blue;
    }
    if (n <= 12) {
      return RobotColors.green;
    }
    return RobotColors.yellow;
  }

  static GoalTypes _buildType(int n) {
    assert(1 <= n && n <= 16);
    if (n % 4 == 1) {
      return GoalTypes.star;
    }
    if (n % 4 == 2) {
      return GoalTypes.planet;
    }
    if (n % 4 == 3) {
      return GoalTypes.sun;
    }
    return GoalTypes.moon;
  }
}
