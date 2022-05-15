import 'dart:math';

import 'package:ricochet_robots/domains/board/board_quarter.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

BoardQuarterGreen randomGreenBoard() => [
      _defaultGreenAlpha,
    ][Random().nextInt(1)];

final _defaultGreenAlpha = BoardQuarterGreen.from(
  goals: {
    const Position(x: 4, y: 1): const Goal(
      color: RobotColors.red,
      type: GoalTypes.moon,
    ),
    const Position(x: 1, y: 2): const Goal(
      color: RobotColors.green,
      type: GoalTypes.sun,
    ),
    const Position(x: 6, y: 3): const Goal(
      color: RobotColors.yellow,
      type: GoalTypes.star,
    ),
    const Position(x: 3, y: 6): const Goal(
      color: RobotColors.blue,
      type: GoalTypes.planet,
    ),
  },
  verticalWalls: {
    const WallPosition(x: 2, y: 0),
    const WallPosition(x: 4, y: 1),
    const WallPosition(x: 2, y: 2),
    const WallPosition(x: 7, y: 3),
    const WallPosition(x: 3, y: 6),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 8, y: 7),
  },
  horizontalWalls: {
    const WallPosition(x: 4, y: 1),
    const WallPosition(x: 1, y: 2),
    const WallPosition(x: 6, y: 4),
    const WallPosition(x: 0, y: 6),
    const WallPosition(x: 3, y: 7),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 7, y: 8),
  },
);
