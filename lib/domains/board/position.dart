enum Directions {
  up,
  right,
  down,
  left,
}

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

  bool equals(Position that) {
    return x == that.x && y == that.y;
  }
}
