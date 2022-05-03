import 'package:flutter/foundation.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:tuple/tuple.dart';

class BoardId {
  final String baseId;
  final String normalGoalId;
  final String wildGoalId;
  final String robotId;

  const BoardId({
    required this.baseId,
    required this.normalGoalId,
    required this.wildGoalId,
    required this.robotId,
  });

  static BoardId from({required Board board}) {
    return BoardId(
      baseId: toBaseId(board: board),
      normalGoalId: toNormalGoalId(board: board),
      wildGoalId: toWildGoalId(board: board),
      robotId: toRobotId(board: board),
    );
  }

  String get value => baseId + normalGoalId + wildGoalId + robotId;
}

@visibleForTesting
String toBaseId({required Board board}) {
  return List.generate(rowLength, (y) {
    return List.generate(
      rowLength,
      (x) => toGridId(grid: board.grids[y][x]),
    ).join();
  }).join();
}

@visibleForTesting
String toGridId({required Grid grid}) {
  return [
    Tuple2(grid.canMoveUp, canMoveUpBit),
    Tuple2(grid.canMoveRight, canMoveRightBit),
    Tuple2(grid.canMoveDown, canMoveDownBit),
    Tuple2(grid.canMoveLeft, canMoveLeftBit),
  ]
      .fold<int>(0, (value, pair) => pair.item1 ? (value | pair.item2) : value)
      .toRadixString(16);
}

String toNormalGoalId({required Board board}) {
  return List.generate(GoalTypes.values.length, (i) {
    return List.generate(
      RobotColors.values.length,
      (j) => toNormalGoalPositionId(
        board: board,
        goalType: GoalTypes.values[i],
        color: RobotColors.values[j],
      ),
    ).join();
  }).join();
}

String toNormalGoalPositionId({
  required Board board,
  required GoalTypes goalType,
  required RobotColors color,
}) {
  final position = List.generate(rowLength, (y) {
    return List.generate(rowLength, (x) {
      final grid = board.grids[y][x];
      if (grid is NormalGoalGrid &&
          grid.color == color &&
          grid.type == goalType) {
        return Position(x: x, y: y);
      }
      return null;
    });
  }).expand((list) => list).whereType<Position>().first;
  return positionToId(position: position);
}

String positionToId({required Position position}) =>
    position.x.toRadixString(16) + position.y.toRadixString(16);

String toWildGoalId({required Board board}) {
  final position = List.generate(rowLength, (y) {
    return List.generate(rowLength, (x) {
      final grid = board.grids[y][x];
      if (grid is WildGoalGrid) {
        return Position(x: x, y: y);
      }
      return null;
    });
  }).expand((list) => list).whereType<Position>().first;
  return positionToId(position: position);
}

String toRobotId({required Board board}) {
  return RobotColors.values.map((color) {
    final position = board.robotPositions[color];
    if (position == null) {
      throw Exception('Robot not found, color: $color');
    }
    return positionToId(position: position);
  }).join();
}
