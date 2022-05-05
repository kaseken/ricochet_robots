import 'package:flutter/material.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/grid.dart';
import 'package:ricochet_robots/domains/board/position.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:ricochet_robots/domains/board/widgets/grid_widget.dart';

class BoardWidget extends StatelessWidget {
  final Board board;

  const BoardWidget({
    Key? key,
    required this.board,
  }) : super(key: key);

  Robot? _robot(int x, int y) => board.getRobotIfExists(Position(x: x, y: y));

  Widget _buildRow(List<Grid> row, int y) {
    return Row(
      children: List.generate(
        row.length,
        (x) => GridWidget(
          grid: row[x],
          robot: _robot(x, y),
        ),
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
