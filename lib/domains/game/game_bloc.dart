import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';
import 'package:ricochet_robots/models/robot.dart';

import '../../models/position.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.init);
}

abstract class GameEvent {}

class SelectColorEvent extends GameEvent {
  final RobotColors color;

  SelectColorEvent({required this.color});
}

class SelectDirectionEvent extends GameEvent {
  final Directions direction;

  SelectDirectionEvent({required this.direction});
}

class SelectGridEvent extends GameEvent {
  final Position position;

  SelectGridEvent({required this.position});
}

class RedoEvent extends GameEvent {}

class SwitchModeEvent extends GameEvent {}
