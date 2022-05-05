import 'package:flutter_test/flutter_test.dart';
import 'package:ricochet_robots/domains/board/board_id.dart';

void main() {
  test('to64based', () {
    const from =
        '420c41461c824028b30d38f41149351559761969b71d79f8218a39259a7a29aabb2dbafc31cb3d35db7e39ebbf3d';
    expect(
      to64based(from: from),
      '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
    );
  });

  test('to16based', () {
    const from =
        '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    expect(
      to16based(from: from),
      '420c41461c824028b30d38f41149351559761969b71d79f8218a39259a7a29aabb2dbafc31cb3d35db7e39ebbf3d',
    );
  });
}
