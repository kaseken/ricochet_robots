import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/history.dart';
import 'package:ricochet_robots/models/robot.dart';

part 'game_state.freezed.dart';

enum GameWidgetMode { play, editBoard }

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
    required Robot selectedRobotForEdit,
  }) = _GameState;

  bool get isEditMode => mode == GameWidgetMode.editBoard;
}
