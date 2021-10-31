import 'package:flutter_test/flutter_test.dart';
import 'package:ricochet_robots/models/board_builder.dart';
import 'package:ricochet_robots/models/position.dart';

void main() {
  group('BoardBuilder', () {
    test('buildGrids', () {
      final grids = BoardBuilder.buildGrids();
      expect(grids.length, equals(16));
      grids.asMap().forEach((y, row) {
        expect(row.length, equals(16));
        row.asMap().forEach((x, grid) {
          if (x == 0) expect(grid.canMove(Directions.left), false);
          if (x == 15) expect(grid.canMove(Directions.right), false);
          if (y == 0) expect(grid.canMove(Directions.up), false);
          if (y == 15) expect(grid.canMove(Directions.down), false);
          if (!grid.canMove(Directions.up) && y - 1 >= 0) {
            expect(grids[y - 1][x].canMove(Directions.down), false);
          }
          if (!grid.canMove(Directions.down) && y + 1 < 16) {
            expect(grids[y + 1][x].canMove(Directions.up), false);
          }
          if (!grid.canMove(Directions.right) && x + 1 < 16) {
            expect(grids[y][x + 1].canMove(Directions.left), false);
          }
          if (!grid.canMove(Directions.left) && x - 1 >= 0) {
            expect(grids[y][x - 1].canMove(Directions.right), false);
          }
        });
      });
    });
  });
}
