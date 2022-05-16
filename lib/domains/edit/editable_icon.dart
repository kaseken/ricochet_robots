import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/edit/edit.dart';
import 'package:ricochet_robots/domains/game/game_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';

class EditableIcon extends StatelessWidget {
  final IconData iconData;
  final Color color;
  final double size;
  final EditAction editAction;
  final GameMode currentMode;

  const EditableIcon({
    Key? key,
    required this.iconData,
    required this.color,
    required this.size,
    required this.editAction,
    required this.currentMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final icon = Icon(
      iconData,
      color: color,
      size: size,
    );
    return currentMode == GameMode.edit
        ? IconButton(
            icon: icon,
            iconSize: size,
            padding: const EdgeInsets.only(),
            onPressed: () => context
                .read<GameBloc>()
                .add(EditBoardEvent(editAction: editAction)),
          )
        : icon;
  }
}
