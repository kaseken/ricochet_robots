import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/grids.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:ricochet_robots/domains/board/robot_positions.dart';

part 'board.freezed.dart';

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
      goal: goal ?? Goal.random,
      robotPositions: robotPositions ?? RobotPositions.random(grids: grids),
    );
  }

  Board moved(Robot robot, Directions direction) {
    final position = robotPositions.position(color: robot.color);
    final otherRobotPositions = robotPositions.others(color: robot.color);
    var updatedRobotPositions = robotPositions; // TODO: make it immutable.
    var to = position; // TODO: make it immutable.
    while (grids.at(position: to).canMove(direction)) {
      to = to.next(direction);
      // TODO: refactor
      if (otherRobotPositions.contains(to)) {
        return copyWith(robotPositions: updatedRobotPositions);
      }
      updatedRobotPositions = updatedRobotPositions.move(
        color: robot.color,
        to: to,
      );
    }
    return copyWith(robotPositions: updatedRobotPositions);
  }

  Board movedTo(Robot robot, Position position) {
    return copyWith(
      robotPositions: robotPositions.move(color: robot.color, to: position),
    );
  }

  bool isGoal(Position position, Robot robot) {
    return grids.at(position: position).isGoal(goal, robot);
  }

  bool hasRobotOnGrid(Position position) =>
      robotPositions.getRobotIfExists(position: position) != null;

  bool hasGoalOnGrid(Position position) =>
      getGoalGridIfExists(position) != null;

  GoalGrid? getGoalGridIfExists(Position position) {
    final grid = grids.at(position: position);
    if (grid is NormalGoalGrid) {
      return grid;
    }
    if (grid is WildGoalGrid) {
      return grid;
    }
    return null;
  }

  Robot? getRobotIfExists({required Position position}) =>
      robotPositions.getRobotIfExists(position: position);

  Board get goalShuffled {
    return copyWith(goal: Goal.random);
  }

  Board get robotShuffled {
    return copyWith(robotPositions: RobotPositions.random(grids: grids));
  }
}
