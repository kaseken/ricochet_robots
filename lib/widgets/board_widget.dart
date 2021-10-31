import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/grid.dart';
import 'package:ricochet_robots/models/robot.dart';
import 'package:ricochet_robots/widgets/grid_widget.dart';

class BoardWidget extends StatelessWidget {
  final Board board;
  final RobotPositions robotPositions;

  const BoardWidget({
    Key? key,
    required this.board,
    required this.robotPositions,
  }) : super(key: key);

  Robot? _robot(int x, int y) {
    for (final robot in robotPositions.entries) {
      if (robot.value.x == x && robot.value.y == y) {
        return Robot(color: robot.key);
      }
    }
    return null;
  }

  Widget _buildRow(List<Grid> row, int y) {
    return Row(
      children: List.generate(
        row.length,
        (x) => GridWidget(grid: row[x], robot: _robot(x, y)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: List.generate(
          board.grids.length,
          (y) => _buildRow(board.grids[y], y),
        ),
      ),
    );
  }
}
