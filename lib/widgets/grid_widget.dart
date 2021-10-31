import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/grid.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';

class GridWidget extends StatelessWidget {
  final Grid grid;
  final Robot? robot;

  const GridWidget({
    Key? key,
    required this.grid,
    this.robot,
  }) : super(key: key);

  Border _buildBorder(Grid grid) {
    const wall = BorderSide(width: 1, color: Colors.grey);
    const border = BorderSide(
      width: 0.5,
      color: Color.fromRGBO(230, 230, 230, 1.0), // TODO: adjust color.
    );
    return Border(
      top: grid.canMove(Directions.up) ? border : wall,
      bottom: grid.canMove(Directions.down) ? border : wall,
      right: grid.canMove(Directions.right) ? border : wall,
      left: grid.canMove(Directions.left) ? border : wall,
    );
  }

  Widget _buildGoal(Grid grid) {
    if (grid is NormalGoalGrid) {
      final iconData = getIcon(grid.type);
      // TODO: change icon to image.
      return Icon(
        iconData,
        color: getActualColor(grid.color),
        size: 20,
      );
    }
    if (grid is WildGoalGrid) {
      // TODO: change icon to image.
      return const Icon(
        Icons.help,
        color: Colors.deepPurple,
        size: 20,
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildRobot(Grid grid, Robot? robot) {
    if (robot != null) {
      return Container(
        decoration: BoxDecoration(
          color: getActualColor(robot.color),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: const Icon(
          Icons.android_outlined,
          color: Colors.white,
          size: 20,
        ),
      );
    }
    return const SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            border: _buildBorder(grid),
          ),
          child: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: _buildGoal(grid),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: _buildRobot(grid, robot),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
