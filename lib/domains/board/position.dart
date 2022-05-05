import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'grids.dart';

part 'position.freezed.dart';

enum Directions {
  up,
  right,
  down,
  left,
}

@freezed
class Position with _$Position {
  static final r = Random();

  const factory Position({
    required int x,
    required int y,
  }) = _Position;

  const Position._();

  static random({
    required Grids grids,
    required Set<Position> used,
  }) {
    final position = Position(x: r.nextInt(16), y: r.nextInt(16));
    if (grids.canPlaceRobotTo(position: position) && !used.contains(position)) {
      return position;
    }
    return random(grids: grids, used: used);
  }

  Position next(Directions directions) {
    switch (directions) {
      case Directions.up:
        return Position(x: x, y: y - 1);
      case Directions.right:
        return Position(x: x + 1, y: y);
      case Directions.down:
        return Position(x: x, y: y + 1);
      case Directions.left:
        return Position(x: x - 1, y: y);
      default:
        return this;
    }
  }
}
