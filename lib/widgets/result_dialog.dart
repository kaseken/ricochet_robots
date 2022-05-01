import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final int moves;
  final void Function() onPressButton;

  const ResultDialog({
    Key? key,
    required this.moves,
    required this.onPressButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: Colors.black12,
        child: AlertDialog(
          title: const Text('Congratulations!'),
          content: Text('Finished in $moves moves.'),
          actions: [
            TextButton(onPressed: onPressButton, child: const Text('OK'))
          ],
        ),
      ),
    );
  }
}
