import 'package:flutter/material.dart';
import 'package:ricochet_robots/models/goal.dart';
import 'package:ricochet_robots/models/history.dart';
import 'package:ricochet_robots/models/robot.dart';

class HeaderWidget extends StatelessWidget {
  final Goal goal;
  final List<History> histories;

  const HeaderWidget({
    Key? key,
    required this.goal,
    required this.histories,
  }) : super(key: key);

  final _textStyle = const TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20,
  );

  Widget _target(Goal goal) {
    return Container(
      height: 20,
      width: 20,
      decoration: BoxDecoration(
        color: getActualColor(goal.color),
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: const Icon(
        Icons.android_outlined,
        color: Colors.white,
        size: 20,
      ),
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
              Icon(
                getIcon(goal.type),
                size: 20,
                color: getActualColor(goal.color),
              ),
            ],
          ),
          Text("${histories.length.toString()} moves", style: _textStyle),
        ],
      ),
    );
  }
}
