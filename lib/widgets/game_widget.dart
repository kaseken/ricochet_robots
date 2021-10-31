import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/robot.dart';
import 'package:ricochet_robots/widgets/board_widget.dart';
import 'package:ricochet_robots/widgets/control_buttons.dart';

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
        constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: AspectRatio(
                aspectRatio: 1,
                child: BoardWidget(board: board),
              ),
            ),
            const ControlButtons(),
          ],
        ),
      ),
    );
  }
}
