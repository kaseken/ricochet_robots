class Robot {
  final RobotColors color;

  const Robot({
    required this.color,
  });
}

abstract class Grid {
  final Map<Directions, bool> _canMove = {};

  bool canMove(Directions directions) {
    return _canMove[directions] ?? false;
  }

  bool isGoal(Goal goal) => false;
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

enum RobotColors {
  red,
  blue,
  green,
  yellow,
}

enum GoalTypes {
  star,
  planet,
  sun,
  moon,
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
  bool isGoal(Goal goal) {
    return !goal.isWild && goal.color == color && goal.type == type;
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
  bool isGoal(Goal goal) => goal.isWild;
}

class CenterGrid extends Grid {}

class Position {
  final int x;
  final int y;

  const Position({
    required this.x,
    required this.y,
  });

  Position next(Directions directions) {
    switch (directions) {
      case Directions.up:
        return Position(x: x, y: y - 1);
      case Directions.right:
        return Position(x: x + 1, y: y);
      case Directions.down:
        return Position(x: x, y: y + 1);
      case Directions.left:
        return Position(x: x - 1, y: y);
      default:
        return this;
    }
  }
}

enum Directions {
  up,
  right,
  down,
  left,
}

class Goal {
  final bool isWild;
  final RobotColors color;
  final GoalTypes type;

  const Goal({
    required this.isWild,
    required this.color,
    required this.type,
  });
}

class Board {
  late final List<List<Grid>> _grids;
  late final Map<RobotColors, Position> _robotPositions;

  Board() {
    _grids = BoardBuilder.buildGrids();
    _robotPositions = {}; // TODO: set positions.
  }

  bool move(Robot robot, Directions direction) {
    final position = _robotPositions[robot.color];
    if (position == null) {
      return false;
    }
    final currentGrid = _grids[position.y][position.x];
    if (currentGrid.canMove(direction)) {
      return false;
    }
    var to = position; // TODO: make it immutable.
    while (_grids[to.y][to.x].canMove(direction)) {
      to = to.next(direction);
    }
    _robotPositions[robot.color] = to;
    return true;
  }

  bool isGoal(Position position, Goal goal) {
    return _grids[position.y][position.x].isGoal(goal);
  }
}

class BoardBuilder {
  // TODO: change patterns randomly.
  static List<List<Grid>> buildGrids() {
    return [
      [
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(canMoveUp: false, canMoveRight: false),
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveDown: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveRight: false),
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(canMoveUp: false, canMoveDown: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.moon,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.planet,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.sun,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.sun,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.star,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false, canMoveDown: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false, canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false, canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.star,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false, canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.planet,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.moon,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false),
        CenterGrid(),
        CenterGrid(),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        WildGoalGrid(canMoveUp: false, canMoveRight: false),
        NormalGrid(canMoveRight: false, canMoveLeft: false),
        CenterGrid(),
        CenterGrid(),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.moon,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveUp: false, canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.planet,
          canMoveRight: false,
          canMoveDown: false,
        ),
        NormalGrid(canMoveRight: false, canMoveLeft: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.planet,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.sun,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
      ],
      [
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.green,
          type: GoalTypes.moon,
          canMoveDown: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(canMoveUp: false, canMoveRight: false),
      ],
      [
        NormalGrid(canMoveUp: false, canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveUp: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveDown: false),
        NormalGrid(),
        NormalGoalGrid(
          color: RobotColors.red,
          type: GoalTypes.star,
          canMoveUp: false,
          canMoveRight: false,
        ),
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.blue,
          type: GoalTypes.star,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveLeft: false),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
        NormalGoalGrid(
          color: RobotColors.yellow,
          type: GoalTypes.sun,
          canMoveUp: false,
          canMoveLeft: false,
        ),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(),
        NormalGrid(canMoveRight: false),
      ],
      [
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
        NormalGrid(canMoveDown: false, canMoveLeft: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveDown: false),
        NormalGrid(canMoveRight: false, canMoveDown: false),
      ],
    ];
  }
}
