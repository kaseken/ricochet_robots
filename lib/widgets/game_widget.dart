import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/grid.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<GameWidget> {
  final board = Board();
  // TODO: set goal randomly.
  final goal = const Goal(
    isWild: false,
    color: RobotColors.red,
    type: GoalTypes.sun,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 800),
        child: Column(
          children: [
            BoardWidget(board: board),
            const NavigationButtons(),
          ],
        ),
      ),
    );
  }
}

class BoardWidget extends StatelessWidget {
  final Board board;

  const BoardWidget({
    Key? key,
    required this.board,
  }) : super(key: key);

  Border _buildBorder(Grid grid) {
    const wall = BorderSide(width: 2, color: Colors.grey);
    const border =
        BorderSide(width: 1, color: Color.fromRGBO(230, 230, 230, 1.0));
    return Border(
      top: grid.canMove(Directions.up) ? border : wall,
      bottom: grid.canMove(Directions.down) ? border : wall,
      right: grid.canMove(Directions.right) ? border : wall,
      left: grid.canMove(Directions.left) ? border : wall,
    );
  }

  Widget _buildGrid(Grid grid) {
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

  Widget _buildRow(List<Grid> row) {
    return Row(
      children: row.map((g) => _buildGrid(g)).toList(),
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

class NavigationButtons extends StatelessWidget {
  const NavigationButtons({Key? key}) : super(key: key);

  List<Expanded> _buildButtons(List<Color> colors) {
    return colors
        .map((color) => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(color),
                  ),
                  onPressed: () => {},
                  child: const SizedBox(
                    height: 50,
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.green, Colors.amber, Colors.blueAccent];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtons(colors),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtons(List.filled(4, Colors.grey)),
        ),
      ],
    );
  }
}
