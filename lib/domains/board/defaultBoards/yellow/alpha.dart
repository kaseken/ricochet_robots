import 'package:ricochet_robots/domains/board/board_quarter.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

final defaultYellowAlpha = BoardQuarterYellow.from(
  goals: {
    const Position(x: 5, y: 1): const Goal(
      color: RobotColors.blue,
      type: GoalTypes.moon,
    ),
    const Position(x: 7, y: 2): const Goal(
      color: null,
      type: null,
    ),
    const Position(x: 3, y: 4): const Goal(
      color: RobotColors.red,
      type: GoalTypes.star,
    ),
    const Position(x: 6, y: 5): const Goal(
      color: RobotColors.green,
      type: GoalTypes.planet,
    ),
    const Position(x: 1, y: 6): const Goal(
      color: RobotColors.yellow,
      type: GoalTypes.sun,
    ),
  },
  verticalWalls: {
    const WallPosition(x: 3, y: 0),
    const WallPosition(x: 5, y: 1),
    const WallPosition(x: 8, y: 2),
    const WallPosition(x: 4, y: 4),
    const WallPosition(x: 6, y: 5),
    const WallPosition(x: 2, y: 6),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 8, y: 7),
  },
  horizontalWalls: {
    const WallPosition(x: 5, y: 2),
    const WallPosition(x: 7, y: 3),
    const WallPosition(x: 0, y: 4),
    const WallPosition(x: 3, y: 5),
    const WallPosition(x: 6, y: 6),
    const WallPosition(x: 1, y: 6),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 7, y: 8),
  },
);
