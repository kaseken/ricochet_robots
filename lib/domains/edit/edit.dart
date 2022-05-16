import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/position.dart';

part 'edit.freezed.dart';

@freezed
class EditAction with _$EditAction {
  const factory EditAction({
    @Default(false) bool nextGoalColor,
    @Default(false) bool nextGoalType,
    Position? position,
    Position? topBorder,
    Position? rightBorder,
    Position? downBorder,
    Position? leftBorder,
  }) = _EditAction;
}

class EditFunction {
  static Board update(
    Board board,
    EditAction action,
    Position? prePosition,
  ) {
    var newBoard = board.copyWith();
    if (action.nextGoalColor) {
      newBoard = newBoard.copyWith(goal: newBoard.goal.nextColor);
    }
    if (action.nextGoalType) {
      newBoard = newBoard.copyWith(goal: newBoard.goal.nextType);
    }
    if (prePosition != null && action.position != null) {
      newBoard = newBoard.copyWith(
        grids: newBoard.grids.swapGoal(prePosition, action.position!),
        robotPositions:
            newBoard.robotPositions.swap(prePosition, action.position!),
      );
    }
    if (action.topBorder != null) {
      newBoard = newBoard.copyWith(
        grids: newBoard.grids.toggleCanMoveUp(action.topBorder!),
      );
    }
    if (action.rightBorder != null) {
      newBoard = newBoard.copyWith(
        grids: newBoard.grids.toggleCanMoveLeft(
            Position(x: action.rightBorder!.x + 1, y: action.rightBorder!.y)),
      );
    }
    if (action.downBorder != null) {
      newBoard = newBoard.copyWith(
        grids: newBoard.grids.toggleCanMoveUp(
            Position(x: action.downBorder!.x, y: action.downBorder!.y + 1)),
      );
    }
    if (action.leftBorder != null) {
      newBoard = newBoard.copyWith(
        grids: newBoard.grids.toggleCanMoveLeft(action.leftBorder!),
      );
    }
    return newBoard;
  }
}
