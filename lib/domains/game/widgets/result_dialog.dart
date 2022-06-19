import 'package:flutter/material.dart';

class ResultDialog extends StatelessWidget {
  final int moves;
  final void Function() onPressCancel;
  final void Function() onPressButton;

  const ResultDialog({
    Key? key,
    required this.moves,
    required this.onPressCancel,
    required this.onPressButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: AlertDialog(
        title: const Text('Congratulations!'),
        content: Text('Finished in $moves moves.'),
        actions: [
          TextButton(onPressed: onPressCancel, child: const Text('Cancel')),
          TextButton(onPressed: onPressButton, child: const Text('Next')),
        ],
      ),
    );
  }
}
