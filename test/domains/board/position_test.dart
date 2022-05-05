import 'package:flutter_test/flutter_test.dart';
import 'package:ricochet_robots/domains/board/position.dart';

void main() {
  test('equals', () {
    const a = Position(x: 1, y: 1);
    const b = Position(x: 1, y: 1);
    expect(a == b, true);
  });

  test('contains', () {
    final set = {const Position(x: 1, y: 1)};
    expect(set.contains(const Position(x: 1, y: 1)), true);
  });
}
