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
    const wall = BorderSide(width: 1.0, color: Colors.grey);
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
      return LayoutBuilder(builder: (context, constraint) {
        return Icon(
          iconData,
          color: getActualColor(grid.color),
          size: constraint.biggest.height,
        );
      });
    }
    if (grid is WildGoalGrid) {
      return LayoutBuilder(builder: (context, constraint) {
        return Icon(
          Icons.help,
          color: Colors.deepPurple,
          size: constraint.biggest.height,
        );
      });
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
        child: LayoutBuilder(builder: (context, constraint) {
          return Icon(
            Icons.android_outlined,
            color: Colors.white,
            size: constraint.biggest.height,
          );
        }),
      );
    }
    return const SizedBox.shrink();
  }

  Color _gridColor(Grid grid) {
    if (grid is CenterGrid) {
      return Colors.grey;
    }
    return Colors.transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Container(
          decoration: BoxDecoration(
            color: _gridColor(grid),
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
