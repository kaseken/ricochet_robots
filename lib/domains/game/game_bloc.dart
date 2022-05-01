import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  GameBloc(initialState) : super(initialState);
}

abstract class GameEvent {}
