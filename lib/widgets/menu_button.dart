import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final void Function() onClick;

  MenuButton({
    Key? key,
    required this.label,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClick,
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
    );
  }
}
