import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/history.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';
import 'package:ricochet_robots/widgets/board_widget.dart';
import 'package:ricochet_robots/widgets/control_buttons.dart';
import 'package:ricochet_robots/widgets/header_widget.dart';

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
  final List<History> _histories = List.empty(growable: true);
  var focusedRobot = const Robot(color: RobotColors.red);

  void _onColorSelected(RobotColors color) {
    setState(() {
      focusedRobot = Robot(color: color);
    });
  }

  void _onDirectionSelected(Directions direction) {
    final currentPosition = board.robotPositions[focusedRobot.color];
    if (currentPosition == null) {
      return;
    }
    setState(() {
      board.move(focusedRobot, direction);
      final nextPosition = board.robotPositions[focusedRobot.color];
      if (nextPosition == null) {
        return;
      }
      if (!nextPosition.equals(currentPosition)) {
        _histories.add(History(
          color: focusedRobot.color,
          position: currentPosition,
        ));
      }
    });
  }

  void _onRedoPressed() {
    if (_histories.isEmpty) {
      return;
    }
    setState(() {
      final prevHistory = _histories.removeLast();
      board.moveTo(Robot(color: prevHistory.color), prevHistory.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderWidget(
                goal: goal,
                histories: _histories,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BoardWidget(
                    board: board,
                    robotPositions: board.robotPositions,
                  ),
                ),
              ),
              ControlButtons(
                onColorSelected: _onColorSelected,
                onDirectionSelected: _onDirectionSelected,
                onRedoPressed: _onRedoPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
