import 'package:flutter_test/flutter_test.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';

void main() {
  group('toGrid', () {
    test('', () {});
  });

  test('charToNormalGrid', () {
    final chars = [
      ...(List.generate(10, (i) => i.toString())),
      ...(List.generate(6, (i) => String.fromCharCode('a'.codeUnitAt(0) + i))),
    ];
    for (final char in chars) {
      final grid = charToNormalGrid(char: char);
      final value = chars.indexOf(char);
      final canMoveUp = value & (1 << 0) > 0;
      final canMoveRight = value & (1 << 1) > 0;
      final canMoveDown = value & (1 << 2) > 0;
      final canMoveLeft = value & (1 << 3) > 0;
      expect(grid.canMoveUp, canMoveUp);
      expect(grid.canMoveRight, canMoveRight);
      expect(grid.canMoveDown, canMoveDown);
      expect(grid.canMoveLeft, canMoveLeft);
    }
  });
}
