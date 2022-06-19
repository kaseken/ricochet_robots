import 'dart:math';

import 'package:ricochet_robots/domains/board/board_quarter.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

BoardQuarterRed randomRedBoard() => [
      _defaultRedAlpha,
      _defaultRedBeta,
      _defaultRedGamma,
    ][Random().nextInt(3)];

final _defaultRedAlpha = BoardQuarterRed.from(
  goals: {
    const Position(x: 4, y: 1): const Goal(
      color: RobotColors.green,
      type: GoalTypes.moon,
    ),
    const Position(x: 1, y: 3): const Goal(
      color: RobotColors.red,
      type: GoalTypes.sun,
    ),
    const Position(x: 5, y: 5): const Goal(
      color: RobotColors.yellow,
      type: GoalTypes.planet,
    ),
    const Position(x: 3, y: 6): const Goal(
      color: RobotColors.blue,
      type: GoalTypes.star,
    ),
  },
  verticalWalls: {
    const WallPosition(x: 2, y: 0),
    const WallPosition(x: 5, y: 1),
    const WallPosition(x: 1, y: 3),
    const WallPosition(x: 5, y: 5),
    const WallPosition(x: 4, y: 6),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 8, y: 7),
  },
  horizontalWalls: {
    const WallPosition(x: 4, y: 1),
    const WallPosition(x: 1, y: 4),
    const WallPosition(x: 5, y: 5),
    const WallPosition(x: 0, y: 6),
    const WallPosition(x: 3, y: 7),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 7, y: 8),
  },
);

final _defaultRedBeta = BoardQuarterRed.from(
  goals: {
    const Position(x: 6, y: 2): const Goal(
      color: RobotColors.green,
      type: GoalTypes.moon,
    ),
    const Position(x: 1, y: 1): const Goal(
      color: RobotColors.red,
      type: GoalTypes.sun,
    ),
    const Position(x: 7, y: 5): const Goal(
      color: RobotColors.yellow,
      type: GoalTypes.planet,
    ),
    const Position(x: 2, y: 4): const Goal(
      color: RobotColors.blue,
      type: GoalTypes.star,
    ),
  },
  verticalWalls: {
    const WallPosition(x: 4, y: 0),
    const WallPosition(x: 1, y: 1),
    const WallPosition(x: 7, y: 2),
    const WallPosition(x: 3, y: 4),
    const WallPosition(x: 7, y: 5),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 8, y: 7),
  },
  horizontalWalls: {
    const WallPosition(x: 1, y: 2),
    const WallPosition(x: 6, y: 2),
    const WallPosition(x: 2, y: 5),
    const WallPosition(x: 7, y: 5),
    const WallPosition(x: 0, y: 6),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 7, y: 8),
  },
);

final _defaultRedGamma = BoardQuarterRed.from(
  goals: {
    const Position(x: 2, y: 4): const Goal(
      color: RobotColors.green,
      type: GoalTypes.moon,
    ),
    const Position(x: 7, y: 5): const Goal(
      color: RobotColors.red,
      type: GoalTypes.sun,
    ),
    const Position(x: 1, y: 6): const Goal(
      color: RobotColors.yellow,
      type: GoalTypes.planet,
    ),
    const Position(x: 5, y: 2): const Goal(
      color: RobotColors.blue,
      type: GoalTypes.star,
    ),
  },
  verticalWalls: {
    const WallPosition(x: 4, y: 0),
    const WallPosition(x: 6, y: 2),
    const WallPosition(x: 3, y: 4),
    const WallPosition(x: 7, y: 5),
    const WallPosition(x: 1, y: 6),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 8, y: 7),
  },
  horizontalWalls: {
    const WallPosition(x: 5, y: 3),
    const WallPosition(x: 2, y: 4),
    const WallPosition(x: 0, y: 5),
    const WallPosition(x: 1, y: 6),
    const WallPosition(x: 7, y: 6),
    const WallPosition(x: 7, y: 7),
    const WallPosition(x: 7, y: 8),
  },
);
