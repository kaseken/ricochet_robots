import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

class History {
  RobotColors color;
  Position position;
  History({
    required this.color,
    required this.position,
  });
}
