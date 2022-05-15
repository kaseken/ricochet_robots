import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';

part 'board_quarter.freezed.dart';

enum BoardQuarterType { red, blue, green, yellow }

class BoardQuarterRed implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  const BoardQuarterRed({required this.gridsQuarter});

  static BoardQuarterRed from({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) {
    return BoardQuarterRed(
      gridsQuarter: GridsQuarter.from(
        goals: goals,
        verticalWalls: verticalWalls,
        horizontalWalls: horizontalWalls,
      ),
    );
  }

  @override
  BoardQuarterRed get rotateRight => BoardQuarterRed(
        gridsQuarter: gridsQuarter.rotateRight,
      );
}

class BoardQuarterBlue implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  const BoardQuarterBlue({required this.gridsQuarter});

  static BoardQuarterBlue from({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) {
    return BoardQuarterBlue(
      gridsQuarter: GridsQuarter.from(
        goals: goals,
        verticalWalls: verticalWalls,
        horizontalWalls: horizontalWalls,
      ),
    );
  }

  @override
  BoardQuarterBlue get rotateRight => BoardQuarterBlue(
        gridsQuarter: gridsQuarter.rotateRight,
      );
}

class BoardQuarterGreen implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  const BoardQuarterGreen({required this.gridsQuarter});

  static BoardQuarterGreen from({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) {
    return BoardQuarterGreen(
      gridsQuarter: GridsQuarter.from(
        goals: goals,
        verticalWalls: verticalWalls,
        horizontalWalls: horizontalWalls,
      ),
    );
  }

  @override
  BoardQuarterGreen get rotateRight => BoardQuarterGreen(
        gridsQuarter: gridsQuarter.rotateRight,
      );
}

class BoardQuarterYellow implements BoardQuarter {
  @override
  final GridsQuarter gridsQuarter;

  const BoardQuarterYellow({required this.gridsQuarter});

  static BoardQuarterYellow from({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) {
    return BoardQuarterYellow(
      gridsQuarter: GridsQuarter.from(
        goals: goals,
        verticalWalls: verticalWalls,
        horizontalWalls: horizontalWalls,
      ),
    );
  }

  @override
  BoardQuarterYellow get rotateRight => BoardQuarterYellow(
        gridsQuarter: gridsQuarter.rotateRight,
      );
}

abstract class BoardQuarter {
  GridsQuarter get gridsQuarter;

  BoardQuarter get rotateRight;
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

  const GridsQuarter({required this.grids});

  static GridsQuarter from({
    required Map<Position, Goal> goals,
    required Set<WallPosition> verticalWalls,
    required Set<WallPosition> horizontalWalls,
  }) {
    return GridsQuarter(
      grids: initGrids(
        goals: goals,
        verticalWalls: verticalWalls,
        horizontalWalls: horizontalWalls,
      ),
    );
  }

  static List<List<Grid>> initGrids({
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

  GridsQuarter get rotateRight {
    return GridsQuarter(
      grids: List.generate(_horizontalLength, (x) {
        return List.generate(_verticalLength, (y) {
          return grids[(_verticalLength - 1) - y][x].rotateRight;
        });
      }),
    );
  }
}
