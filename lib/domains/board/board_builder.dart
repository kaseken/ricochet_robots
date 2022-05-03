import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

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
      if (grids[y][x] is NormalGrid) {
        positions.add(Position(x: x, y: y));
      }
    }
    return positions;
  }

  static List<List<Grid>> buildDefaultGrids() {
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
        CenterGrid(),
        CenterGrid(),
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
        CenterGrid(),
        CenterGrid(),
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
  assert(id.length == rowLength * rowLength);
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
  if (value < 0 || 16 <= value) {
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
