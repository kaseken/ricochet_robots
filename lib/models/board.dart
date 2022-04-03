import 'package:ricochet_robots/models/board_builder.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/grid.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';

typedef RobotPositions = Map<RobotColors, Position>;

typedef Grids = List<List<Grid>>;

class Board {
  final Grids grids;
  late final RobotPositions robotPositions;

  Board({required this.grids, RobotPositions? robotPositions}) {
    if (robotPositions != null) {
      this.robotPositions = robotPositions;
      return;
    }
    final positions = BoardBuilder.buildInitialPositions(grids);
    assert(positions.length == 4);
    this.robotPositions = {
      RobotColors.red: positions[0],
      RobotColors.blue: positions[1],
      RobotColors.green: positions[2],
      RobotColors.yellow: positions[3],
    };
  }

  Board _updatedWith({
    Grids? grids,
    RobotPositions? robotPositions,
  }) {
    return Board(
      grids: grids ?? this.grids,
      robotPositions: robotPositions ?? this.robotPositions,
    );
  }

  Board moved(Robot robot, Directions direction) {
    final position = robotPositions[robot.color];
    if (position == null) {
      return this; // unexpected.
    }
    final otherRobotPositions = robotPositions.entries
        .where((e) => e.key != robot.color)
        .map((e) => e.value);
    final updatedRobotPositions = robotPositions;
    var to = position; // TODO: make it immutable.
    while (grids[to.y][to.x].canMove(direction)) {
      to = to.next(direction);
      // TODO: refactor
      final otherRobotExists = otherRobotPositions
          .where((p) => p.x == to.x && p.y == to.y)
          .isNotEmpty;
      if (otherRobotExists) {
        return _updatedWith(robotPositions: updatedRobotPositions);
      }
      updatedRobotPositions[robot.color] = to;
    }
    return _updatedWith(robotPositions: updatedRobotPositions);
  }

  Board movedTo(Robot robot, Position position) {
    final updatedRobotPositions = robotPositions;
    updatedRobotPositions[robot.color] = position;
    return _updatedWith(robotPositions: updatedRobotPositions);
  }

  bool isGoal(Position position, Goal goal, Robot robot) {
    return grids[position.y][position.x].isGoal(goal, robot);
  }
}
