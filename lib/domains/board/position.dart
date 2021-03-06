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

Directions opposite({required Directions direction}) =>
    Directions.values[(direction.index + 2) % 4];

@freezed
class Position with _$Position {
  static final _random = Random();

  const factory Position({
    required int x,
    required int y,
  }) = _Position;

  const Position._();

  static random({
    required Grids grids,
    required Set<Position> used,
  }) {
    final position = Position(x: _random.nextInt(16), y: _random.nextInt(16));
    if (grids.canPlaceRobotTo(position: position) && !used.contains(position)) {
      return position;
    }
    return random(grids: grids, used: used);
  }

  Position next(Directions directions) {
    switch (directions) {
      case Directions.up:
        return copyWith(y: y - 1);
      case Directions.right:
        return copyWith(x: x + 1);
      case Directions.down:
        return copyWith(y: y + 1);
      case Directions.left:
        return copyWith(x: x - 1);
    }
  }

  Position get rotateRight {
    return Position(x: -y + 16 - 1, y: x);
  }

  Position get rotateLeft {
    return Position(x: y, y: -x + 16 - 1);
  }
}
