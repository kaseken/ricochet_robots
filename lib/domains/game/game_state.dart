import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:ricochet_robots/domains/game/history.dart';

part 'game_state.freezed.dart';

enum GameWidgetMode { play, showResult }

@freezed
class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required GameWidgetMode mode,

    /// Properties for playing.
    required Board board,
    required Goal goal,
    required List<History> histories,
    required Robot focusedRobot,
  }) = _GameState;

  bool get shouldShowResult => mode == GameWidgetMode.showResult;

  static GameState initialize({required String? boardId}) {
    if (boardId == null) {
      return _reset();
    }
    try {
      final board = toBoard(id: boardId);
      return _reset(board: board);
    } on Exception {
      return _reset();
    }
  }

  /// Reset state and returns new state.
  static GameState _reset({Board? board, Goal? goal, GameWidgetMode? mode}) {
    return GameState(
      mode: mode ?? GameWidgetMode.play,
      board: board ?? Board(grids: BoardBuilder.defaultGrids),
      goal: goal ?? GoalBuilder.build(),
      histories: List.empty(growable: true),
      focusedRobot: const Robot(color: RobotColors.red),
    );
  }

  GameState onColorSelected({required RobotColors color}) =>
      copyWith(focusedRobot: Robot(color: color));

  GameState onDirectionSelected({required Directions direction}) {
    final currentPosition = board.robotPositions[focusedRobot.color];
    if (currentPosition == null) {
      return this;
    }
    final nextBoard = board.moved(focusedRobot, direction);
    final nextPosition = board.robotPositions[focusedRobot.color];
    if (nextPosition == null) {
      return copyWith(board: nextBoard);
    }
    final history = History(
      color: focusedRobot.color,
      position: currentPosition,
    );
    final nextHistories = !nextPosition.equals(currentPosition)
        ? [...histories, history]
        : histories;
    if (board.isGoal(nextPosition, goal, focusedRobot)) {
      return copyWith(
        mode: GameWidgetMode.showResult,
        board: nextBoard,
        histories: nextHistories,
      );
    }
    return copyWith(board: nextBoard, histories: nextHistories);
  }

  GameState onRedoPressed() {
    if (histories.isEmpty) {
      return this;
    }
    final prevHistory = histories.last;
    return copyWith(
      histories: histories.take(histories.length - 1).toList(),
      board: board.movedTo(
        Robot(color: prevHistory.color),
        prevHistory.position,
      ),
    );
  }

  GameState onRestart() => _reset(mode: GameWidgetMode.play);
}
