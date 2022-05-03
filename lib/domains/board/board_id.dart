import 'package:flutter/foundation.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:tuple/tuple.dart';

class BoardId {
  final String baseId;

  const BoardId({
    required this.baseId,
  });

  String get value => baseId;
}

@visibleForTesting
String baseId({required Board board}) {
  return List.generate(rowLength, (y) {
    return List.generate(
      rowLength,
      (x) => toGridId(grid: board.grids[y][x]),
    ).join('');
  }).join('');
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
