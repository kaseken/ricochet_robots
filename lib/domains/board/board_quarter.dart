import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';

part 'board_quarter.freezed.dart';

enum BoardQuarterType { red, blue, green, yellow }

class BoardQuarterRed implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  BoardQuarterRed({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) : gridsQuarter = GridsQuarter(
          goals: goals,
          verticalWalls: verticalWalls,
          horizontalWalls: horizontalWalls,
        );
}

class BoardQuarterBlue implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  BoardQuarterBlue({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) : gridsQuarter = GridsQuarter(
          goals: goals,
          verticalWalls: verticalWalls,
          horizontalWalls: horizontalWalls,
        );
}

class BoardQuarterGreen implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  BoardQuarterGreen({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) : gridsQuarter = GridsQuarter(
          goals: goals,
          verticalWalls: verticalWalls,
          horizontalWalls: horizontalWalls,
        );
}

class BoardQuarterYellow implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  BoardQuarterYellow({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) : gridsQuarter = GridsQuarter(
          goals: goals,
          verticalWalls: verticalWalls,
          horizontalWalls: horizontalWalls,
        );
}

abstract class BoardQuarter {
  GridsQuarter get gridsQuarter;
}

@freezed
class WallPosition with _$WallPosition {
  const factory WallPosition({
    required int x,
    required int y,
  }) = _WallPosition;
}

class GridsQuarter {
  static const _horizontalLength = 8;
  static const _verticalLength = 8;

  final List<List<Grid>> grids;

  GridsQuarter({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) : grids = init(
          goals: goals,
          verticalWalls: verticalWalls,
          horizontalWalls: horizontalWalls,
        );

  static List<List<Grid>> init({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) {
    return List.generate(_verticalLength, (y) {
      return List.generate(_horizontalLength, (x) {
        final hasTopWall =
            y == 0 || horizontalWalls.contains(WallPosition(x: x, y: y));
        final hasBottomWall =
            horizontalWalls.contains(WallPosition(x: x, y: y + 1));
        final hasLeftWall =
            x == 0 || verticalWalls.contains(WallPosition(x: x, y: y));
        final hasRightWall =
            verticalWalls.contains(WallPosition(x: x + 1, y: y));
        final maybeGoal = goals[Position(x: x, y: y)];
        if (maybeGoal != null) {
          final goalType = maybeGoal.type;
          final goalColor = maybeGoal.color;
          if (goalType == null || goalColor == null) {
            return WildGoalGrid(
              canMoveUp: !hasTopWall,
              canMoveLeft: !hasLeftWall,
              canMoveDown: !hasBottomWall,
              canMoveRight: !hasRightWall,
            );
          }
          return NormalGoalGrid(
            color: goalColor,
            type: goalType,
            canMoveUp: !hasTopWall,
            canMoveLeft: !hasLeftWall,
            canMoveDown: !hasBottomWall,
            canMoveRight: !hasRightWall,
          );
        }
        return NormalGrid(
          canMoveUp: !hasTopWall,
          canMoveLeft: !hasLeftWall,
          canMoveDown: !hasBottomWall,
          canMoveRight: !hasRightWall,
        );
      });
    });
  }
}
