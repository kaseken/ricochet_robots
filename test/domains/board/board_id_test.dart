import 'package:flutter_test/flutter_test.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';
import 'package:ricochet_robots/domains/board/board_id.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

void main() {
  group('BoardId', () {
    test('from', () {
      final grids = BoardBuilder.defaultGrids;
      final robotPositions = Map.fromEntries([
        const MapEntry(RobotColors.red, Position(x: 12, y: 12)),
        const MapEntry(RobotColors.blue, Position(x: 14, y: 2)),
        const MapEntry(RobotColors.green, Position(x: 15, y: 7)),
        const MapEntry(RobotColors.yellow, Position(x: 0, y: 13)),
      ]);
      final board = Board(
        grids: grids,
        robotPositions: robotPositions,
        goal: const Goal(type: GoalTypes.moon, color: RobotColors.red),
      );
      final boardId = BoardId.from(board: board);
      expect(
        boardId.value,
        '6c6eaeeeeeec6aec7bfd6fffffffd6fd7c7ffffff97ffffd7fffff97fefffff97fffffeffffffffc3ffffffffffbfd3d6fd3fffbbffc7fed7ffefbd007fffffd7ffffc5007fffffd797ffffeafffff957efd3fffc7ffffe93fffefffffffd3fc6ffffbffffbffefd7ffbfc7ffd6ffffd7fd6fffffffffffd3bbbbb93bbb93bb95dade563d1364ae98a92123e4119dbb658cce2f70d30',
      );
    });
  });
}
