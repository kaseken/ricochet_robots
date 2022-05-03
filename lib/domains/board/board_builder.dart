import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:tuple/tuple.dart';

class BoardBuilder {
  static List<Position> buildInitialPositions(List<List<Grid>> grids) {
    final List<Position> positions = List.empty(growable: true);
    final random = Random();
    while (positions.length < 4) {
      final x = random.nextInt(16);
      final y = random.nextInt(16);
      if (positions.where((p) => p.x == x && p.y == y).isNotEmpty) {
        continue;
      }
      if (grids[y][x].canPlaceRobot) {
        positions.add(Position(x: x, y: y));
      }
    }
    return positions;
  }

  static List<List<Grid>> get defaultGrids {
    return [
      [
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(canMoveUp: false, canMoveRight: false),
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveDown: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveRight: false),
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(canMoveUp: false, canMoveDown: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.moon,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.planet,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.sun,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.sun,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.star,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false, canMoveDown: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false, canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false, canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.star,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false, canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.planet,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.moon,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false),
        NormalGrid(
          canMoveUp: false,
          canMoveRight: false,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(
          canMoveUp: false,
          canMoveRight: false,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        WildGoalGrid(canMoveUp: false, canMoveRight: false),
        NormalGrid(canMoveRight: false, canMoveLeft: false),
        NormalGrid(
          canMoveUp: false,
          canMoveRight: false,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(
          canMoveUp: false,
          canMoveRight: false,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.moon,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.planet,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveRight: false, canMoveLeft: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.planet,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.sun,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
      ],
      [
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.moon,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(canMoveUp: false, canMoveRight: false),
      ],
      [
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.star,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.star,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.sun,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
      ],
    ];
  }
}

String gridsToId({required List<List<Grid>> grids}) {
  return '';
}

const _baseIdStart = 0;
const _baseIdLength = rowLength * rowLength;
const _normalGoalIdStart = _baseIdStart + _baseIdLength;
const _normalGoalIdLength = 4 * 4 * 2;
const _wildGoalIdStart = _normalGoalIdStart + _normalGoalIdLength;
const _wildGoalIdLength = 2;
const _robotIdStart = _wildGoalIdStart + _wildGoalIdLength;
const _robotIdLength = 4 * 2;
const _idLength =
    _baseIdLength + _normalGoalIdLength + _wildGoalIdLength + _robotIdLength;

Board toBoard({required String id}) => Board(
      grids: toGrids(id: id),
      robotPositions: toRobotPositions(id: id),
    );

@visibleForTesting
List<List<Grid>> toGrids({required String id}) {
  assert(id.length == _baseIdLength);
  final baseId = id.substring(_baseIdStart, _baseIdStart + _baseIdLength);
  final baseGrids = addEdges(grids: toNormalGrids(id: baseId));
  final normalGoalId = id.substring(
    _normalGoalIdStart,
    _normalGoalIdStart + _normalGoalIdLength,
  );
  final gridsWithNormalGoal = putNormalGoals(
    baseGrids: baseGrids,
    goalId: normalGoalId,
  );
  final wildGoalId = id.substring(
    _wildGoalIdStart,
    _wildGoalIdStart + _wildGoalIdLength,
  );
  return putWildGoalGrid(grids: gridsWithNormalGoal, id: wildGoalId);
}

final _chars = [
  /// '0' to '9'
  ...(List.generate(10, (i) => i.toString())),

  /// 'a' to 'z'
  ...(List.generate(26, (i) => String.fromCharCode('a'.codeUnitAt(0) + i))),

  /// 'A' to 'Z'
  ...(List.generate(26, (i) => String.fromCharCode('A'.codeUnitAt(0) + i))),

  '_',
  '-',
];

const _canMoveUpBit = 1 << 0;
const _canMoveRightBit = 1 << 1;
const _canMoveDownBit = 1 << 2;
const _canMoveLeftBit = 1 << 3;

const rowLength = 16;

@visibleForTesting
List<List<NormalGrid>> toNormalGrids({required String id}) {
  assert(id.length == _normalGoalIdLength);
  return intoChunks(id: id, chunkSize: rowLength)
      .map((id) => toNormalGridRow(id: id))
      .toList();
}

@visibleForTesting
List<String> intoChunks({
  required String id,
  required int chunkSize,
  List<String> result = const [],
}) {
  if (id.length <= chunkSize) {
    return [...result, id];
  }
  return intoChunks(
    id: id.substring(chunkSize),
    chunkSize: chunkSize,
    result: [...result, id.substring(0, chunkSize)],
  );
}

List<NormalGrid> toNormalGridRow({required String id}) {
  assert(id.length == 16);
  return id.split('').map((char) => charToNormalGrid(char: char)).toList();
}

@visibleForTesting
NormalGrid charToNormalGrid({required String char}) {
  final value = _chars.indexOf(char);
  if (value < 0 || rowLength <= value) {
    /// Unexpected.
    return NormalGrid();
  }
  return NormalGrid(
    canMoveUp: value & _canMoveUpBit > 0,
    canMoveRight: value & _canMoveRightBit > 0,
    canMoveDown: value & _canMoveDownBit > 0,
    canMoveLeft: value & _canMoveLeftBit > 0,
  );
}

@visibleForTesting
List<List<NormalGrid>> addEdges({required List<List<NormalGrid>> grids}) {
  return List.generate(rowLength, (y) {
    return List.generate(rowLength, (x) {
      final grid = grids[y][x];
      return NormalGrid(
        canMoveUp: grid.canMoveUp && y - 1 >= 0,
        canMoveRight: grid.canMoveRight && x + 1 < 16,
        canMoveDown: grid.canMoveDown && y + 1 < 16,
        canMoveLeft: grid.canMoveLeft && x - 1 >= 0,
      );
    });
  });
}

@visibleForTesting
List<List<Grid>> putNormalGoals({
  required List<List<NormalGrid>> baseGrids,
  required String goalId,
}) {
  return getNormalGoalPositions(goalId: goalId)
      .fold<List<List<Grid>>>(baseGrids, (grids, tuple) {
    return putNormalGoalGrid(
      grids: grids,
      goalType: tuple.item1,
      color: tuple.item2,
      position: tuple.item3,
    );
  });
}

@visibleForTesting
List<Tuple3<GoalTypes, RobotColors, Position>> getNormalGoalPositions({
  required String goalId,
}) {
  assert(goalId.length == _normalGoalIdLength);
  return List.generate(GoalTypes.values.length, (i) {
    return List.generate(RobotColors.values.length, (j) {
      final start = (i * RobotColors.values.length + j) * 2;
      return Tuple3(
        GoalTypes.values[i],
        RobotColors.values[j],
        getPosition(id: goalId.substring(start, start + 2)),
      );
    });
  }).expand((list) => list).toList();
}

@visibleForTesting
Position getPosition({required String id}) {
  assert(id.length == 2);
  final x = _chars.indexOf(id[0]);
  final y = _chars.indexOf(id[1]);
  assert(0 <= x && x < rowLength);
  assert(0 <= y && y < rowLength);
  return Position(x: x, y: y);
}

List<List<Grid>> putNormalGoalGrid({
  required List<List<Grid>> grids,
  required RobotColors color,
  required GoalTypes goalType,
  required Position position,
}) {
  return List.generate(rowLength, (y) {
    return List.generate(rowLength, (x) {
      if (position.x != x || position.y != y) {
        return grids[y][x];
      }
      return NormalGoalGrid(
        type: goalType,
        color: color,
        canMoveUp: grids[y][x].canMoveUp,
        canMoveRight: grids[y][x].canMoveRight,
        canMoveDown: grids[y][x].canMoveDown,
        canMoveLeft: grids[y][x].canMoveLeft,
      );
    });
  });
}

List<List<Grid>> putWildGoalGrid({
  required List<List<Grid>> grids,
  required String id,
}) {
  assert(id.length == _wildGoalIdLength);
  final position = getPosition(id: id);
  return List.generate(rowLength, (y) {
    return List.generate(rowLength, (x) {
      if (position.x != x || position.y != y) {
        return grids[y][x];
      }
      return WildGoalGrid(
        canMoveUp: grids[y][x].canMoveUp,
        canMoveRight: grids[y][x].canMoveRight,
        canMoveDown: grids[y][x].canMoveDown,
        canMoveLeft: grids[y][x].canMoveLeft,
      );
    });
  });
}

RobotPositions toRobotPositions({required String id}) {
  assert(id.length == _idLength);
  final robotId = id.substring(_robotIdStart, _robotIdStart + _robotIdLength);
  return Map.fromEntries(
    List.generate(
      RobotColors.values.length,
      (i) => MapEntry(
        RobotColors.values[i],
        getPosition(id: robotId.substring(i * 2, i * 2 + 2)),
      ),
    ),
  );
}
