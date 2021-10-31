import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/position.dart';
import 'package:ricochet_robots/models/robot.dart';

class ControlButtons extends StatelessWidget {
  final Function(RobotColors color) onColorSelected;
  final Function(Directions direction) onDirectionSelected;
  final Function() onRedoPressed;

  const ControlButtons({
    Key? key,
    required this.onColorSelected,
    required this.onDirectionSelected,
    required this.onRedoPressed,
  }) : super(key: key);

  List<Expanded> _buildColorButtons(List<RobotColors> colors) {
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
                onPressed: () => onColorSelected(color),
                child: const SizedBox(
                  height: 50,
                  child: Icon(
                    Icons.android_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildDirectionButtons(List<Directions> directions) {
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
          size: 30,
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
                onPressed: () => onDirectionSelected(direction),
                child: SizedBox(
                  height: 50,
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
                children:
                    _buildColorButtons([RobotColors.red, RobotColors.blue]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:
                    _buildColorButtons([RobotColors.green, RobotColors.yellow]),
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
                children: _buildDirectionButtons([
                  Directions.up,
                ]),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: _buildDirectionButtons([
                  Directions.left,
                  Directions.down,
                  Directions.right,
                ]),
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
                        onPressed: onRedoPressed,
                        child: const SizedBox(
                          height: 108,
                          child: Icon(
                            Icons.replay,
                            color: Colors.white,
                            size: 30,
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
