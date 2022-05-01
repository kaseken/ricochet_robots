import 'package:flutter/material.dart';
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
                    onTapGrid: isEditMode ? _onTapGrid : null,
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
