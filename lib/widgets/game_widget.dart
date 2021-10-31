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
  late Board _board;
  // TODO: set goal randomly.
  late Goal _goal;
  late List<History> _histories;
  late Robot _focusedRobot;

  void _onColorSelected(RobotColors color) {
    setState(() {
      _focusedRobot = Robot(color: color);
    });
  }

  @override
  void initState() {
    super.initState();
    _reset();
  }

  void _reset() {
    setState(() {
      _board = Board();
      _goal = GoalBuilder.build();
      _histories = List.empty(growable: true);
      _focusedRobot = const Robot(color: RobotColors.red);
    });
  }

  void _onDirectionSelected(Directions direction) {
    final currentPosition = _board.robotPositions[_focusedRobot.color];
    if (currentPosition == null) {
      return;
    }
    setState(() {
      _board.move(_focusedRobot, direction);
      final nextPosition = _board.robotPositions[_focusedRobot.color];
      if (nextPosition == null) {
        return;
      }
      if (!nextPosition.equals(currentPosition)) {
        _histories.add(History(
          color: _focusedRobot.color,
          position: currentPosition,
        ));
      }
      if (_board.isGoal(nextPosition, _goal, _focusedRobot)) {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Congratulations!'),
            content: Text('Finished in ${_histories.length} moves.'),
            actions: [
              TextButton(
                onPressed: () {
                  _reset();
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              )
            ],
          ),
        );
      }
    });
  }

  void _onRedoPressed() {
    if (_histories.isEmpty) {
      return;
    }
    setState(() {
      final prevHistory = _histories.removeLast();
      _board.moveTo(Robot(color: prevHistory.color), prevHistory.position);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(2.0),
          constraints: const BoxConstraints(maxWidth: 800, maxHeight: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderWidget(
                goal: _goal,
                histories: _histories,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BoardWidget(
                    board: _board,
                    robotPositions: _board.robotPositions,
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
