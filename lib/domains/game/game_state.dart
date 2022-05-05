import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/board_builder.dart';
import 'package:ricochet_robots/domains/board/board_id.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:ricochet_robots/domains/game/history.dart';

part 'game_state.freezed.dart';

enum GameMode { play, showResult }

@freezed
class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required GameMode mode,
    required Board board,
    required List<History> histories,
    required Robot focusedRobot,
  }) = _GameState;

  bool get shouldShowResult => mode == GameMode.showResult;

  static GameState initialize({required BoardId? boardId}) {
    final board = boardId != null
        ? toBoard(boardId: boardId)
        : toBoard(boardId: BoardId.defaultId).goalShuffled.robotShuffled;
    return init(board: board);
  }

  /// Reset state and returns new state.
  @visibleForTesting
  static GameState init({required Board board}) {
    return GameState(
      mode: GameMode.play,
      board: board,
      histories: [],
      focusedRobot: const Robot(color: RobotColors.red),
    );
  }

  GameState onColorSelected({required RobotColors color}) =>
      copyWith(focusedRobot: Robot(color: color));

  GameState onDirectionSelected({required Directions direction}) {
    final currentPosition =
        board.robotPositions.position(color: focusedRobot.color);
    final nextBoard = board.moved(focusedRobot, direction);
    final nextPosition =
        nextBoard.robotPositions.position(color: focusedRobot.color);
    final history = History(
      color: focusedRobot.color,
      position: currentPosition,
    );
    final nextHistories =
        nextPosition != currentPosition ? [...histories, history] : histories;
    if (board.isGoal(nextPosition, focusedRobot)) {
      return copyWith(
        mode: GameMode.showResult,
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

  GameState onRestart() =>
      copyWith(board: board.robotShuffled.goalShuffled).initialized;

  GameState get initialized => copyWith(
        mode: GameMode.play,
        histories: [],
      );
}
