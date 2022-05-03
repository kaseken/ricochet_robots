import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';

abstract class Grid {
  final Map<Directions, bool> _canMove = {};

  bool canMove(Directions directions) {
    return _canMove[directions] ?? false;
  }

  bool isGoal(Goal goal, Robot robot) => false;
}

class NormalGrid extends Grid {
  NormalGrid({
    bool canMoveUp = true,
    bool canMoveDown = true,
    bool canMoveLeft = true,
    bool canMoveRight = true,
  }) {
    _canMove[Directions.up] = canMoveUp;
    _canMove[Directions.down] = canMoveDown;
    _canMove[Directions.left] = canMoveLeft;
    _canMove[Directions.right] = canMoveRight;
  }
}

abstract class GoalGrid extends Grid {}

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
  }) {
    _canMove[Directions.up] = canMoveUp;
    _canMove[Directions.down] = canMoveDown;
    _canMove[Directions.left] = canMoveLeft;
    _canMove[Directions.right] = canMoveRight;
  }

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
  }) {
    _canMove[Directions.up] = canMoveUp;
    _canMove[Directions.down] = canMoveDown;
    _canMove[Directions.left] = canMoveLeft;
    _canMove[Directions.right] = canMoveRight;
  }

  @override
  bool isGoal(Goal goal, Robot robot) =>
      goal.color == null && goal.type == null;
}

class CenterGrid extends Grid {}
