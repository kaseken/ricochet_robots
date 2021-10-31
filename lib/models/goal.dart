import 'package:ricochet_robots/models/robot.dart';

enum GoalTypes {
  star,
  planet,
  sun,
  moon,
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
