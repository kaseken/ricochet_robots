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

    /// Properties for playing.
    required Board board,
    required List<History> histories,
    required Robot focusedRobot,
  }) = _GameState;

  bool get shouldShowResult => mode == GameMode.showResult;

  static GameState initialize({required BoardId? boardId}) {
    if (boardId == null) {
      return _reset();
    }
    try {
      final board = toBoard(boardId: boardId);
      return _reset(board: board);
    } on Exception {
      return _reset();
    }
  }

  /// Reset state and returns new state.
  static GameState _reset({Board? board, GameMode? mode}) {
    return GameState(
      mode: mode ?? GameMode.play,
      board: board ?? Board.init(grids: BoardBuilder.defaultGrids),
      histories: List.empty(growable: true),
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

  GameState onRestart() => shuffleRobots.shuffleGoal.initialized;

  GameState get shuffleRobots => copyWith(board: board.robotShuffled);

  GameState get shuffleGoal => copyWith(board: board.goalShuffled);

  GameState get initialized => copyWith(
        mode: GameMode.play,
        histories: [],
      );
}
