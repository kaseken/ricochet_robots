import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/grid.dart';

enum BoardQuarterType { red, blue, green, yellow }

class BoardQuarterRed implements BoardQuarter {
  @override
  final GridsQuarter grids;

  const BoardQuarterRed({required this.grids});
}

class BoardQuarterBlue implements BoardQuarter {
  @override
  final GridsQuarter grids;

  const BoardQuarterBlue({required this.grids});
}

class BoardQuarterGreen implements BoardQuarter {
  @override
  final GridsQuarter grids;

  const BoardQuarterGreen({required this.grids});
}

class BoardQuarterYellow implements BoardQuarter {
  @override
  final GridsQuarter grids;

  const BoardQuarterYellow({required this.grids});
}

abstract class BoardQuarter {
  GridsQuarter get grids;
}

class WallPosition {
  final int rowNumber;
  final int columnNumber;

  const WallPosition({
    required this.rowNumber,
    required this.columnNumber,
  });
}

class GridsQuarter {
  static const _horizontalLength = 8;
  static const _verticalLength = 8;

  final List<List<Grid>> grids;

  GridsQuarter({
    required List<Goal> goals,
    required List<WallPosition> verticalWalls,
    required List<WallPosition> horizontalWalls,
  }) : grids = init(
          goals: goals,
          verticalWalls: verticalWalls,
          horizontalWalls: horizontalWalls,
        );

  static List<List<Grid>> init({
    required List<Goal> goals,
    required List<WallPosition> verticalWalls,
    required List<WallPosition> horizontalWalls,
  }) {
    return List.generate(_verticalLength, (y) {
      return List.generate(_horizontalLength, (x) {
        /// TODO: set goal if exists.
        /// TODO: set walls
        return NormalGrid();
      });
    });
  }
}
