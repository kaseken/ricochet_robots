import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';

class Grids {
  final List<List<Grid>> grids;

  const Grids({required this.grids});

  bool canPlaceRobotTo({required Position position}) =>
      grids[position.y][position.x].canPlaceRobot;

  Grid at({required Position position}) => grids[position.y][position.x];

  Grid? _safeAt({required Position position}) {
    if (position.y < 0 || position.y >= grids.length) {
      return null;
    }
    if (position.x < 0 || position.x >= grids[position.y].length) {
      return null;
    }
    return at(position: position);
  }

  int get length => grids.length;

  List<Grid> row({required int y}) => grids[y];

  Grids swap(Position a, Position b) {
    final newGrids = List.generate(grids.length, (y) {
      return List.generate(grids[y].length, (x) {
        final position = Position(x: x, y: y);
        if (position == a) {
          return at(position: b);
        }
        if (position == b) {
          return at(position: a);
        }
        return at(position: position);
      });
    });
    return Grids(grids: newGrids);
  }

  Grids toggleCanMoveUp(Position lowerPosition) {
    final upperPosition = Position(x: lowerPosition.x, y: lowerPosition.y - 1);
    final upperGrid = _safeAt(position: upperPosition);
    final lowerGrid = _safeAt(position: lowerPosition);
    if (upperGrid == null || lowerGrid == null) {
      return this;
    }
    final newGrids = List.generate(grids.length, (y) {
      return List.generate(grids[y].length, (x) {
        final position = Position(x: x, y: y);
        if (position == upperPosition) {
          return upperGrid.setCanMove(
            directions: Directions.down,
            canMove: !lowerGrid.canMoveUp,
          );
        }
        if (position == lowerPosition) {
          return lowerGrid.setCanMove(
            directions: Directions.up,
            canMove: !lowerGrid.canMoveUp,
          );
        }
        return at(position: position);
      });
    });
    return Grids(grids: newGrids);
  }

  Grids toggleCanMoveLeft(Position rightPosition) {
    final leftPosition = Position(x: rightPosition.x - 1, y: rightPosition.y);
    final rightGrid = _safeAt(position: rightPosition);
    final leftGrid = _safeAt(position: leftPosition);
    if (rightGrid == null || leftGrid == null) {
      return this;
    }
    final newGrids = List.generate(grids.length, (y) {
      return List.generate(grids[y].length, (x) {
        final position = Position(x: x, y: y);
        if (position == rightPosition) {
          return rightGrid.setCanMove(
            directions: Directions.left,
            canMove: !rightGrid.canMoveLeft,
          );
        }
        if (position == leftPosition) {
          return leftGrid.setCanMove(
            directions: Directions.right,
            canMove: !rightGrid.canMoveLeft,
          );
        }
        return at(position: position);
      });
    });
    return Grids(grids: newGrids);
  }
}
