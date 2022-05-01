import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/board_builder.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/history.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';

part 'game_state.freezed.dart';

enum GameWidgetMode { play, showResult, editBoard }

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

    /// Properties for editing.
    required Board customBoard,
    required Robot? selectedRobotForEdit,
  }) = _GameState;

  bool get isEditMode => mode == GameWidgetMode.editBoard;

  bool get shouldShowResult => mode == GameWidgetMode.showResult;

  static GameState get init => _reset();

  /// Reset state and returns new state.
  static GameState _reset({Board? newBoard, GameWidgetMode? mode}) {
    final board = newBoard ?? Board(grids: BoardBuilder.buildDefaultGrids());
    return GameState(
      mode: mode ?? GameWidgetMode.play,
      board: board,
      goal: GoalBuilder.build(),
      histories: List.empty(growable: true),
      focusedRobot: const Robot(color: RobotColors.red),
      customBoard: board,
      selectedRobotForEdit: null,
    );
  }

  /// Switches from the given mode, and returns new state.
  GameState switchMode() {
    switch (mode) {
      case GameWidgetMode.play:
        return copyWith(customBoard: board, mode: GameWidgetMode.editBoard);
      case GameWidgetMode.showResult:
        return this;
      case GameWidgetMode.editBoard:
        return _reset(newBoard: customBoard, mode: GameWidgetMode.play);
    }
  }

  GameState onTapGrid({required Position position}) {
    final maybeExistingRobot = customBoard.getRobotIfExists(position);
    if (maybeExistingRobot != null) {
      /// Select robot on tapped grid.
      return copyWith(selectedRobotForEdit: maybeExistingRobot);
    }

    final selectedRobot = selectedRobotForEdit;
    if (selectedRobot == null || customBoard.hasGoalOnGrid(position)) {
      return this;
    }
    return copyWith(
      customBoard: customBoard.movedTo(selectedRobot, position),
      selectedRobotForEdit: null,
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
