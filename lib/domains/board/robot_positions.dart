import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/grids.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

part 'robot_positions.freezed.dart';

@freezed
class RobotPositions with _$RobotPositions {
  const RobotPositions._();

  const factory RobotPositions({
    required Position red,
    required Position blue,
    required Position green,
    required Position yellow,
  }) = _RobotPositions;

  static RobotPositions init({required Grids grids}) {
    final red = Position.random(grids: grids, used: {});
    final blue = Position.random(grids: grids, used: {red});
    final green = Position.random(grids: grids, used: {red, blue});
    final yellow = Position.random(grids: grids, used: {red, blue, green});
    return RobotPositions(red: red, blue: blue, green: green, yellow: yellow);
  }

  Position position({required RobotColors color}) {
    switch (color) {
      case RobotColors.red:
        return red;
      case RobotColors.blue:
        return blue;
      case RobotColors.green:
        return green;
      case RobotColors.yellow:
        return yellow;
    }
  }

  Set<Position> others({required RobotColors color}) => RobotColors.values
      .where((c) => c != color)
      .map((c) => position(color: c))
      .toSet();

  RobotPositions move({required RobotColors color, required Position to}) {
    return RobotPositions(
      red: color == RobotColors.red ? to : red,
      blue: color == RobotColors.blue ? to : blue,
      green: color == RobotColors.green ? to : green,
      yellow: color == RobotColors.yellow ? to : yellow,
    );
  }

  Robot? getRobotIfExists({required Position position}) {
    if (position == red) {
      return Robot.red;
    }
    if (position == blue) {
      return Robot.blue;
    }
    if (position == green) {
      return Robot.green;
    }
    if (position == yellow) {
      return Robot.yellow;
    }
    return null;
  }
}
