import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';

class Grids {
  final List<List<Grid>> grids;

  const Grids({required this.grids});

  bool canPlaceRobotTo({required Position position}) =>
      grids[position.y][position.x].canPlaceRobot;

  Grid at({required Position position}) => grids[position.y][position.x];

  int get length => grids.length;

  List<Grid> row({required int y}) => grids[y];

  Grids swapGoal(Position a, Position b) {
    final newGrids = [...grids];
    final gridA = newGrids[a.y][a.x];
    final gridACanMoveUp = gridA.canMoveUp;
    final gridACanMoveRight = gridA.canMoveRight;
    final gridACanMoveDown = gridA.canMoveDown;
    final gridACanMoveLeft = gridA.canMoveLeft;
    final gridB = newGrids[b.y][b.x];
    final gridBCanMoveUp = gridB.canMoveUp;
    final gridBCanMoveRight = gridB.canMoveRight;
    final gridBCanMoveDown = gridB.canMoveDown;
    final gridBCanMoveLeft = gridB.canMoveLeft;
    newGrids[a.y][a.x] = gridB;
    newGrids[a.y][a.x].canMoveUp = gridACanMoveUp;
    newGrids[a.y][a.x].canMoveRight = gridACanMoveRight;
    newGrids[a.y][a.x].canMoveDown = gridACanMoveDown;
    newGrids[a.y][a.x].canMoveLeft = gridACanMoveLeft;
    newGrids[b.y][b.x] = gridA;
    newGrids[b.y][b.x].canMoveUp = gridBCanMoveUp;
    newGrids[b.y][b.x].canMoveRight = gridBCanMoveRight;
    newGrids[b.y][b.x].canMoveDown = gridBCanMoveDown;
    newGrids[b.y][b.x].canMoveLeft = gridBCanMoveLeft;
    return Grids(grids: newGrids);
  }

  Grids toggleCanMoveUp(Position a) {
    final newGrids = [...grids];
    if (!(1 <= a.y &&
        a.y < newGrids.length &&
        0 <= a.x &&
        a.x < newGrids[a.y].length)) {
      return Grids(grids: newGrids);
    }
    final grid = newGrids[a.y][a.x];
    final newCanMoveUp = !grid.canMoveUp;
    newGrids[a.y][a.x].canMoveUp = newCanMoveUp;
    newGrids[a.y - 1][a.x].canMoveDown = newCanMoveUp;
    return Grids(grids: newGrids);
  }

  Grids toggleCanMoveLeft(Position a) {
    final newGrids = [...grids];
    if (!(0 <= a.y &&
        a.y < newGrids.length &&
        1 <= a.x &&
        a.x < newGrids[a.y].length)) {
      return Grids(grids: newGrids);
    }
    final grid = newGrids[a.y][a.x];
    final newCanMoveLeft = !grid.canMoveLeft;
    newGrids[a.y][a.x].canMoveLeft = newCanMoveLeft;
    newGrids[a.y][a.x - 1].canMoveRight = newCanMoveLeft;
    return Grids(grids: newGrids);
  }
}
