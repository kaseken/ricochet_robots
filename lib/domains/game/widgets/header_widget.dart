import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/board/board.dart';
import 'package:ricochet_robots/domains/board/board_id.dart';
import 'package:ricochet_robots/domains/board/goal.dart';
import 'package:ricochet_robots/domains/board/robot.dart';
import 'package:ricochet_robots/domains/game/game_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';
import 'package:ricochet_robots/domains/game/history.dart';

class HeaderWidget extends StatelessWidget {
  static const _iconSize = 24.0;

  final Board board;
  final List<History> histories;
  final GameMode currentMode;

  const HeaderWidget({
    Key? key,
    required this.board,
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

  Future<void> _copyUrlToClipBoard() async {
    final id = BoardId.from(board: board);
    await Clipboard.setData(
      ClipboardData(text: '${Uri.base.toString()}?id=${id.encoded}'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Row(
            children: [
              Text("Move ", style: _textStyle),
              _target(board.goal),
              Text(" to ", style: _textStyle),
              _goal(board.goal),
            ],
          ),
          const Expanded(child: SizedBox.shrink()),
          Text("${histories.length.toString()} moves", style: _textStyle),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () => context.read<GameBloc>().add(const RestartEvent()),
            icon: const Icon(
              Icons.refresh,
              color: Colors.grey,
              size: _iconSize,
            ),
          ),
          IconButton(
            onPressed: _copyUrlToClipBoard,
            icon: const Icon(
              Icons.link,
              color: Colors.grey,
              size: _iconSize,
            ),
          ),
        ],
      ),
    );
  }
}
