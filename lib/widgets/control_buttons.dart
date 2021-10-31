import 'package:flutter/material.dart';

class ControlButtons extends StatelessWidget {
  const ControlButtons({Key? key}) : super(key: key);

  List<Expanded> _buildButtons(List<Color> colors) {
    return colors
        .map(
          (color) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(color),
                ),
                onPressed: () => {},
                child: const SizedBox(
                  height: 50,
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [Colors.red, Colors.green, Colors.amber, Colors.blueAccent];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtons(colors),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: _buildButtons(List.filled(4, Colors.grey)),
        ),
      ],
    );
  }
}
