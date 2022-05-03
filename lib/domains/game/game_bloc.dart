import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';
import 'package:ricochet_robots/models/robot.dart';

import '../../models/position.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc({required String? boardId})
      : super(GameState.initialize(boardId: boardId)) {
    on<SelectColorEvent>(
      (event, emit) => emit(state.onColorSelected(color: event.color)),
    );
    on<SelectDirectionEvent>(
      (event, emit) =>
          emit(state.onDirectionSelected(direction: event.direction)),
    );
    on<RedoEvent>((event, emit) => emit(state.onRedoPressed()));
    on<RestartEvent>((event, emit) => emit(state.onRestart()));
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

class RedoEvent extends GameEvent {
  const RedoEvent();
}

class RestartEvent extends GameEvent {
  const RestartEvent();
}
