import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

abstract class Grid {
  final bool canMoveUp;
  final bool canMoveRight;
  final bool canMoveDown;
  final bool canMoveLeft;

  const Grid({
    this.canMoveUp = false,
    this.canMoveRight = false,
    this.canMoveDown = false,
    this.canMoveLeft = false,
  });

  bool canMove(Directions directions) {
    switch (directions) {
      case Directions.up:
        return canMoveUp;
      case Directions.right:
        return canMoveRight;
      case Directions.down:
        return canMoveDown;
      case Directions.left:
        return canMoveLeft;
    }
  }

  bool isGoal(Goal goal, Robot robot) => false;

  bool get canPlaceRobot {
    if (this is! NormalGrid) {
      return false;
    }
    return canMoveUp || canMoveRight || canMoveDown || canMoveLeft;
  }

  /// Use for center grid.
  bool get isInactiveGrid {
    return (this is NormalGrid) &&
        !canMoveUp &&
        !canMoveRight &&
        !canMoveDown &&
        !canMoveLeft;
  }
}

class NormalGrid extends Grid {
  NormalGrid({
    bool canMoveUp = true,
    bool canMoveDown = true,
    bool canMoveLeft = true,
    bool canMoveRight = true,
  }) : super(
          canMoveUp: canMoveUp,
          canMoveRight: canMoveRight,
          canMoveDown: canMoveDown,
          canMoveLeft: canMoveLeft,
        );
}

abstract class GoalGrid extends Grid {
  const GoalGrid({
    required bool canMoveUp,
    required bool canMoveDown,
    required bool canMoveLeft,
    required bool canMoveRight,
  }) : super(
          canMoveUp: canMoveUp,
          canMoveRight: canMoveRight,
          canMoveDown: canMoveDown,
          canMoveLeft: canMoveLeft,
        );
}

class NormalGoalGrid extends GoalGrid {
  final RobotColors color;
  final GoalTypes type;

  NormalGoalGrid({
    this.color = RobotColors.red,
    this.type = GoalTypes.star,
    bool canMoveUp = true,
    bool canMoveDown = true,
    bool canMoveLeft = true,
    bool canMoveRight = true,
  }) : super(
          canMoveUp: canMoveUp,
          canMoveRight: canMoveRight,
          canMoveDown: canMoveDown,
          canMoveLeft: canMoveLeft,
        );

  @override
  bool isGoal(Goal goal, Robot robot) {
    return goal.color == color && goal.type == type && robot.color == color;
  }
}

class WildGoalGrid extends GoalGrid {
  WildGoalGrid({
    bool canMoveUp = true,
    bool canMoveDown = true,
    bool canMoveLeft = true,
    bool canMoveRight = true,
  }) : super(
          canMoveUp: canMoveUp,
          canMoveRight: canMoveRight,
          canMoveDown: canMoveDown,
          canMoveLeft: canMoveLeft,
        );

  @override
  bool isGoal(Goal goal, Robot robot) =>
      goal.color == null && goal.type == null;
}
