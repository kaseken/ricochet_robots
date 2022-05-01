import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';
import 'package:ricochet_robots/widgets/board_widget.dart';
import 'package:ricochet_robots/widgets/control_buttons.dart';
import 'package:ricochet_robots/widgets/header_widget.dart';
import 'package:ricochet_robots/widgets/result_dialog.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({Key? key}) : super(key: key);

  Widget _buildFooter({
    required BuildContext context,
    required GameWidgetMode currentMode,
  }) {
    final bloc = context.read<GameBloc>();
    return ControlButtons(
      onColorSelected: ({required RobotColors color}) =>
          bloc.add(SelectColorEvent(color: color)),
      onDirectionSelected: ({required Directions direction}) =>
          bloc.add(SelectDirectionEvent(direction: direction)),
      onRedoPressed: () => bloc.add(const RedoEvent()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameBloc, GameState>(
      builder: (context, state) {
        final bloc = context.read<GameBloc>();
        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Card(
                child: Container(
                  padding: const EdgeInsets.all(2.0),
                  constraints: const BoxConstraints(
                    maxWidth: 800,
                    maxHeight: 800,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      HeaderWidget(
                        goal: state.goal,
                        histories: state.histories,
                        currentMode: state.mode,
                      ),
                      Expanded(
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: BoardWidget(board: state.board),
                        ),
                      ),
                      _buildFooter(
                        context: context,
                        currentMode: state.mode,
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: state.shouldShowResult,
                child: ResultDialog(
                  moves: state.histories.length,
                  onPressButton: () => bloc.add(const RestartEvent()),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
