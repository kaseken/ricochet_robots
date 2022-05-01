import 'package:flutter/material.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/history.dart';
import 'package:ricochet_robots/models/robot.dart';

class HeaderWidget extends StatelessWidget {
  final Goal goal;
  final List<History> histories;
  final GameWidgetMode currentMode;

  const HeaderWidget({
    Key? key,
    required this.goal,
    required this.histories,
    required this.currentMode,
  }) : super(key: key);

  final _textStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  Widget _target(Goal goal) {
    final color = goal.color;
    if (color == null) {
      return Text(
        "Any Robot",
        style: _textStyle,
      );
    }
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: getActualColor(color),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: const Icon(
        Icons.android_outlined,
        color: Colors.white,
        size: 20,
      ),
    );
  }

  Widget _goal(Goal goal) {
    final type = goal.type;
    final color = goal.color;
    if (type == null || color == null) {
      return const Icon(
        Icons.help,
        size: 20,
        color: Colors.deepPurple,
      );
    }
    return Icon(
      getIcon(type),
      size: 20,
      color: getActualColor(color),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("Move ", style: _textStyle),
              _target(goal),
              Text(" to ", style: _textStyle),
              _goal(goal),
            ],
          ),
          Text("${histories.length.toString()} moves", style: _textStyle),
        ],
      ),
    );
  }
}
