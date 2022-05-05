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
}
