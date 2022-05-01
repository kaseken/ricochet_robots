import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ricochet_robots/domains/game/game_bloc.dart';
import 'package:ricochet_robots/widgets/game_widget.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ricochet robots trainer',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: BlocProvider(
        create: (BuildContext context) => GameBloc(),
        child: const Home(title: 'Ricochet Robots Trainer'),
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: GameWidget(),
    );
  }
}
