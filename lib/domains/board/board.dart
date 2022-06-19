import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/board_quarter.dart';
import 'package:ricochet_robots/domains/board/defaultBoards/green/boards.dart';
import 'package:ricochet_robots/domains/board/defaultBoards/red/boards.dart';
import 'package:ricochet_robots/domains/board/defaultBoards/yellow/boards.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/grids.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:ricochet_robots/domains/board/robot_positions.dart';

import 'defaultBoards/blue/boards.dart';

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

  static Board get random {
    return synthesize(
      boardQuarterRed: randomRedBoard(),
      boardQuarterBlue: randomBlueBoard(),
      boardQuarterGreen: randomGreenBoard(),
      boardQuarterYellow: randomYellowBoard(),
    );
  }

  static Board synthesize({
    required BoardQuarterRed boardQuarterRed,
    required BoardQuarterBlue boardQuarterBlue,
    required BoardQuarterGreen boardQuarterGreen,
    required BoardQuarterYellow boardQuarterYellow,
  }) {
    final boardQuarters = [
      boardQuarterRed,
      boardQuarterBlue,
      boardQuarterGreen,
      boardQuarterYellow
    ]..shuffle();

    /// TODO: refactoring
    final topLeftGrids = boardQuarters[0].gridsQuarter.grids;
    final topRightGrids = boardQuarters[1].rotateRight.gridsQuarter.grids;
    final bottomRightGrids =
        boardQuarters[2].rotateRight.rotateRight.gridsQuarter.grids;
    final bottomLeftGrids =
        boardQuarters[3].rotateRight.rotateRight.rotateRight.gridsQuarter.grids;
    final leftHalfGrids = topLeftGrids + bottomLeftGrids;
    final rightHalfGrids = topRightGrids + bottomRightGrids;
    return init(
      grids: Grids(
        grids: fixQuarterBorder(
          List.generate(leftHalfGrids.length, (y) {
            return leftHalfGrids[y] + rightHalfGrids[y];
          }),
        ),
      ),
    );
  }

  static List<List<Grid>> fixQuarterBorder(List<List<Grid>> grids) {
    final halfLengthY = (grids.length / 2).floor();
    return List.generate(grids.length, (y) {
      final halfLengthX = (grids[y].length / 2).floor();
      return List.generate(grids[y].length, (x) {
        if (y == halfLengthY - 1) {
          return grids[y][x].setCanMove(
            directions: Directions.down,
            canMove: grids[y][x].canMoveDown && grids[y + 1][x].canMoveUp,
          );
        }
        if (y == halfLengthY) {
          return grids[y][x].setCanMove(
            directions: Directions.up,
            canMove: grids[y - 1][x].canMoveDown && grids[y][x].canMoveUp,
          );
        }
        if (x == halfLengthX - 1) {
          return grids[y][x].setCanMove(
            directions: Directions.right,
            canMove: grids[y][x].canMoveRight && grids[y][x + 1].canMoveLeft,
          );
        }
        if (x == halfLengthX) {
          return grids[y][x].setCanMove(
            directions: Directions.left,
            canMove: grids[y][x - 1].canMoveRight && grids[y][x].canMoveLeft,
          );
        }
        return grids[y][x];
      });
    });
  }

  Board moved(Robot robot, Directions direction) {
    return copyWith(
      robotPositions: robotPositions.movedAsPossible(
        board: this,
        robot: robot,
        direction: direction,
      ),
    );
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
