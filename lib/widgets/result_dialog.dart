import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final int moves;

  const ResultDialog({
    Key? key,
    required this.moves,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Congratulations!'),
      content: Text('Finished in $moves moves.'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    );
  }
}
