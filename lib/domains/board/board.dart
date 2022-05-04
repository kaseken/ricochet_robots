import 'package:collection/collection.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

typedef RobotPositions = Map<RobotColors, Position>;

typedef Grids = List<List<Grid>>;

class Board {
  final Grids grids;
  final RobotPositions robotPositions;

  Board({
    required this.grids,
    RobotPositions? robotPositions,
  }) : robotPositions = robotPositions ?? initRobotPositions(grids: grids);

  static RobotPositions initRobotPositions({required List<List<Grid>> grids}) {
    final positions = BoardBuilder.buildInitialPositions(grids);
    return Map.fromEntries(
      List.generate(
        RobotColors.values.length,
        (i) => MapEntry(RobotColors.values[i], positions[i]),
      ),
    );
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

  bool hasRobotOnGrid(Position position) => getRobotIfExists(position) != null;

  Robot? getRobotIfExists(Position position) {
    return robotPositions.entries
        .where((entry) {
          return entry.value.x == position.x && entry.value.y == position.y;
        })
        .map((p) => Robot(color: p.key))
        .firstOrNull;
  }

  bool hasGoalOnGrid(Position position) =>
      getGoalGridIfExists(position) != null;

  GoalGrid? getGoalGridIfExists(Position position) {
    final grid = grids[position.y][position.x];
    if (grid is NormalGoalGrid) {
      return grid;
    }
    if (grid is WildGoalGrid) {
      return grid;
    }
    return null;
  }
}
