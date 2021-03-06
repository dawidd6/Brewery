import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final String label;
  final Widget Function(BuildContext) pageBuilder;

  MenuButton({
    Key? key,
    required this.label,
    required this.pageBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: pageBuilder,
        ),
      ),
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
