import 'package:ricochet_robots/models/board_builder.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/grid.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';

typedef RobotPositions = Map<RobotColors, Position>;

class Board {
  late final List<List<Grid>> grids;
  late final RobotPositions robotPositions;

  Board() {
    grids = BoardBuilder.buildGrids();
    final positions = BoardBuilder.buildInitialPositions(grids);
    assert(positions.length == 4);
    robotPositions = {
      RobotColors.red: positions[0],
      RobotColors.blue: positions[1],
      RobotColors.green: positions[2],
      RobotColors.yellow: positions[3],
    };
  }

  RobotPositions move(Robot robot, Directions direction) {
    final position = robotPositions[robot.color];
    if (position == null) {
      return robotPositions;
    }
    final otherRobotPositions = robotPositions.entries
        .where((e) => e.key != robot.color)
        .map((e) => e.value);
    var to = position; // TODO: make it immutable.
    while (grids[to.y][to.x].canMove(direction)) {
      to = to.next(direction);
      // TODO: refactor
      final otherRobotExists = otherRobotPositions
          .where((p) => p.x == to.x && p.y == to.y)
          .isNotEmpty;
      if (otherRobotExists) {
        return robotPositions;
      }
      robotPositions[robot.color] = to;
    }
    return robotPositions;
  }

  void moveTo(Robot robot, Position position) {
    robotPositions[robot.color] = position;
  }

  bool isGoal(Position position, Goal goal, Robot robot) {
    return grids[position.y][position.x].isGoal(goal, robot);
  }
}
