import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/board.dart';
import 'package:ricochet_robots/models/board_builder.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/history.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';
import 'package:ricochet_robots/widgets/board_widget.dart';
import 'package:ricochet_robots/widgets/control_buttons.dart';
import 'package:ricochet_robots/widgets/header_widget.dart';

enum GameWidgetMode { play, editBoard }

class GameWidget extends StatefulWidget {
  const GameWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _State();
}

class _State extends State<GameWidget> {
  GameWidgetMode _mode = GameWidgetMode.play;
  bool get isEditMode => _mode == GameWidgetMode.editBoard;

  late Board _board;
  late Goal _goal;
  late List<History> _histories;
  late Robot _focusedRobot;

  late Board _customBoard;
  Robot? _selectedRobotForEdit;

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

  void _reset({Board? newBoard}) {
    /// TODO: Retrieve newBoard from URL.
    setState(() {
      _board = newBoard ?? Board(grids: BoardBuilder.buildDefaultGrids());
      _customBoard = _board;
      _goal = GoalBuilder.build();
      _histories = List.empty(growable: true);
      _focusedRobot = const Robot(color: RobotColors.red);
    });
  }

  void _switchMode({required GameWidgetMode from}) {
    switch (from) {
      case GameWidgetMode.play:
        return setState(() {
          _customBoard = _board;
          _mode = GameWidgetMode.editBoard;
        });
      case GameWidgetMode.editBoard:
        _reset(newBoard: _customBoard);
        return setState(() {
          _mode = GameWidgetMode.play;
        });
    }
  }

  void _onTapGrid({required int x, required int y}) {
    final tappedPosition = Position(x: x, y: y);
    final maybeExistingRobot = _customBoard.getRobotIfExists(tappedPosition);
    if (maybeExistingRobot != null) {
      /// Select robot on tapped grid.
      return setState(() {
        _selectedRobotForEdit = maybeExistingRobot;
      });
    }

    final selectedRobot = _selectedRobotForEdit;
    if (selectedRobot != null) {
      if (_customBoard.hasGoalOnGrid(tappedPosition)) {
        /// Skip if already has goal.
        return;
      }
      return setState(() {
        /// Move robot to tapped position.
        _customBoard = _customBoard.movedTo(selectedRobot, tappedPosition);
        _selectedRobotForEdit = null;
      });
    }
  }

  void _onDirectionSelected(Directions direction) {
    final currentPosition = _board.robotPositions[_focusedRobot.color];
    if (currentPosition == null) {
      return;
    }
    setState(() {
      _board = _board.moved(_focusedRobot, direction);
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
        final moves = _histories.length;
        _reset();
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) => AlertDialog(
            title: const Text('Congratulations!'),
            content: Text('Finished in $moves moves.'),
            actions: [
              TextButton(
                onPressed: () {
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
    final prevHistory = _histories.removeLast();
    setState(() {
      _board = _board.movedTo(
        Robot(color: prevHistory.color),
        prevHistory.position,
      );
    });
  }

  Widget _buildFooter({required GameWidgetMode currentMode}) {
    switch (currentMode) {
      case GameWidgetMode.play:
        return ControlButtons(
          onColorSelected: _onColorSelected,
          onDirectionSelected: _onDirectionSelected,
          onRedoPressed: _onRedoPressed,
        );
      case GameWidgetMode.editBoard:
        return const SizedBox.shrink();
    }
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
                currentMode: _mode,
                switchMode: _switchMode,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: BoardWidget(
                    board: isEditMode ? _customBoard : _board,
                    onTapGrid: _onTapGrid,
                  ),
                ),
              ),
              _buildFooter(currentMode: _mode),
            ],
          ),
        ),
      ),
    );
  }
}
