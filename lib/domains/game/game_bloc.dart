import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';
import 'package:ricochet_robots/models/robot.dart';

import '../../models/position.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc() : super(GameState.init) {
    on<SelectColorEvent>(
      (event, emit) => emit(state.onColorSelected(color: event.color)),
    );
    on<SelectDirectionEvent>(
      (event, emit) =>
          emit(state.onDirectionSelected(direction: event.direction)),
    );
    on<SelectGridEvent>(
      (event, emit) => emit(state.onTapGrid(position: event.position)),
    );
    on<RedoEvent>((event, emit) => emit(state.onRedoPressed()));
    on<SwitchModeEvent>((event, emit) => emit(state.switchMode()));
  }
}

abstract class GameEvent {
  const GameEvent();
}

class SelectColorEvent extends GameEvent {
  final RobotColors color;

  const SelectColorEvent({required this.color});
}

class SelectDirectionEvent extends GameEvent {
  final Directions direction;

  const SelectDirectionEvent({required this.direction});
}

class SelectGridEvent extends GameEvent {
  final Position position;

  const SelectGridEvent({required this.position});
}

class RedoEvent extends GameEvent {
  const RedoEvent();
}

class SwitchModeEvent extends GameEvent {
  const SwitchModeEvent();
}
