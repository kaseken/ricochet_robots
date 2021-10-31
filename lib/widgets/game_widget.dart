import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/position.dart';
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
  var focusedRobot = const Robot(color: RobotColors.red);
  late RobotPositions robotPositions;

  @override
  void initState() {
    super.initState();
    robotPositions = board.robotPositions;
  }

  void _onColorSelected(RobotColors color) {
    setState(() {
      focusedRobot = Robot(color: color);
    });
  }

  void _onDirectionSelected(Directions direction) {
    setState(() {
      robotPositions = board.move(focusedRobot, direction);
    });
  }

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
                child: BoardWidget(
                  board: board,
                  robotPositions: robotPositions,
                ),
              ),
            ),
            ControlButtons(
              onColorSelected: _onColorSelected,
              onDirectionSelected: _onDirectionSelected,
            ),
          ],
        ),
      ),
    );
  }
}
