import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/grid.dart';
import 'package:ricochet_robots/widgets/grid_widget.dart';

class BoardWidget extends StatelessWidget {
  final Board board;

  const BoardWidget({
    Key? key,
    required this.board,
  }) : super(key: key);

  Widget _buildRow(List<Grid> row) {
    return Row(
      children: row.map((g) => GridWidget(grid: g)).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Column(
        children: board.grids.map((row) => _buildRow(row)).toList(),
      ),
    );
  }
}
