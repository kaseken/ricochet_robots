import 'package:collection/collection.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

part 'board.freezed.dart';

typedef RobotPositions = Map<RobotColors, Position>;

typedef Grids = List<List<Grid>>;

@freezed
class Board with _$Board {
  const factory Board({
    required Grids grids,
    required Goal goal,
    required RobotPositions robotPositions,
  }) = _Board;

  const Board._();

  static Board init({
    required Grids grids,
    Goal? goal,
    RobotPositions? robotPositions,
  }) {
    return Board(
      grids: grids,
      goal: goal ?? GoalBuilder.build(),
      robotPositions: robotPositions ?? initRobotPositions(grids: grids),
    );
  }

  static RobotPositions initRobotPositions({required List<List<Grid>> grids}) {
    final positions = BoardBuilder.buildInitialPositions(grids);
    return Map.fromEntries(
      List.generate(
        RobotColors.values.length,
        (i) => MapEntry(RobotColors.values[i], positions[i]),
      ),
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
    final updatedRobotPositions =
        Map<RobotColors, Position>.from(robotPositions);
    var to = position; // TODO: make it immutable.
    while (grids[to.y][to.x].canMove(direction)) {
      to = to.next(direction);
      // TODO: refactor
      final otherRobotExists = otherRobotPositions
          .where((p) => p.x == to.x && p.y == to.y)
          .isNotEmpty;
      if (otherRobotExists) {
        return copyWith(robotPositions: updatedRobotPositions);
      }
      updatedRobotPositions[robot.color] = to;
    }
    return copyWith(robotPositions: updatedRobotPositions);
  }

  Board movedTo(Robot robot, Position position) {
    final updatedRobotPositions =
        Map<RobotColors, Position>.from(robotPositions);
    updatedRobotPositions[robot.color] = position;
    return copyWith(robotPositions: updatedRobotPositions);
  }

  bool isGoal(Position position, Robot robot) {
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
