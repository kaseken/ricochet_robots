import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';
import 'package:ricochet_robots/widgets/board_widget.dart';
import 'package:ricochet_robots/widgets/control_buttons.dart';
import 'package:ricochet_robots/widgets/header_widget.dart';
import 'package:ricochet_robots/widgets/result_dialog.dart';

class GameWidget extends StatelessWidget {
  const GameWidget({Key? key}) : super(key: key);

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
                      const ControlButtons(),
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
