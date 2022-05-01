import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_bloc.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({Key? key}) : super(key: key);

  void _onColorSelected({
    required BuildContext context,
    required RobotColors color,
  }) {
    context.read<GameBloc>().add(SelectColorEvent(color: color));
  }

  void _onDirectionSelected({
    required BuildContext context,
    required Directions direction,
  }) {
    context.read<GameBloc>().add(SelectDirectionEvent(direction: direction));
  }

  void _onRedoPressed({required BuildContext context}) =>
      context.read<GameBloc>().add(const RedoEvent());

  List<Expanded> _buildColorButtons({
    required BuildContext context,
    required List<RobotColors> colors,
  }) {
    return colors
        .map(
          (color) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    getActualColor(color),
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  alignment: Alignment.center,
                ),
                onPressed: () => _onColorSelected(
                  context: context,
                  color: color,
                ),
                child: const SizedBox(
                  height: 30,
                  child: Icon(
                    Icons.android_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildDirectionButtons({
    required BuildContext context,
    required List<Directions> directions,
  }) {
    IconData? _getLabel(Directions direction) {
      switch (direction) {
        case Directions.up:
          return Icons.arrow_upward;
        case Directions.down:
          return Icons.arrow_downward;
        case Directions.right:
          return Icons.arrow_forward;
        case Directions.left:
          return Icons.arrow_back;
        default:
          return null;
      }
    }

    Icon? _getIcon(Directions direction) {
      final label = _getLabel(direction);
      if (label != null) {
        return Icon(
          label,
          size: 20,
          color: Colors.white,
        );
      }
      return null;
    }

    return directions
        .map(
          (direction) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  // TODO: change color.
                  backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.grey,
                  ),
                  padding: MaterialStateProperty.all(EdgeInsets.zero),
                  alignment: Alignment.center,
                ),
                onPressed: () => _onDirectionSelected(
                  context: context,
                  direction: direction,
                ),
                child: SizedBox(
                  height: 30,
                  child: _getIcon(direction),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildColorButtons(
                  context: context,
                  colors: [RobotColors.red, RobotColors.blue],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildColorButtons(
                  context: context,
                  colors: [RobotColors.green, RobotColors.yellow],
                ),
              ),
            ],
          ),
          flex: 2,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildDirectionButtons(
                  context: context,
                  directions: [Directions.up],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildDirectionButtons(
                  context: context,
                  directions: [
                    Directions.left,
                    Directions.down,
                    Directions.right,
                  ],
                ),
              ),
            ],
          ),
          flex: 3,
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.grey,
                          ), // TODO: change color.
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                          alignment: Alignment.center,
                        ),
                        onPressed: () => _onRedoPressed(context: context),
                        child: const SizedBox(
                          height: 68,
                          child: Icon(
                            Icons.replay,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
          flex: 1,
        ),
      ],
    );
  }
}
