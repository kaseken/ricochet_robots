import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/grid.dart';
import 'package:ricochet_robots/models/position.dart';

class GridWidget extends StatelessWidget {
  final Grid grid;
  const GridWidget({
    Key? key,
    required this.grid,
  }) : super(key: key);

  Border _buildBorder(Grid grid) {
    const wall = BorderSide(width: 2, color: Colors.grey);
    const border = BorderSide(
      width: 1,
      color: Color.fromRGBO(230, 230, 230, 1.0), // TODO: adjust color.
    );
    return Border(
      top: grid.canMove(Directions.up) ? border : wall,
      bottom: grid.canMove(Directions.down) ? border : wall,
      right: grid.canMove(Directions.right) ? border : wall,
      left: grid.canMove(Directions.left) ? border : wall,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: ConstrainedBox(
          constraints: const BoxConstraints(),
          child: DecoratedBox(
            decoration: BoxDecoration(
              border: _buildBorder(grid),
            ),
          ),
        ),
      ),
    );
  }
}
