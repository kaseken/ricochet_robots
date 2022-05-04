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
        'r6WKXKXIqKNX-m-----m-nN----Vv--Zv---B-X---B----L-----3------_-QZrZf-_X-Yv_R--LLg1----n---507---Zun---G---Vl_-j--N---Wj--X----ZfYr--X--_--LR-_-N--m---n-m-------ZeXKXAXKVeXBtHulzQjpaWoGi4zV16tKSmcPyZMQM',
      );
    });
  });

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
