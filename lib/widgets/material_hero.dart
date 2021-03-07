import 'package:flutter/material.dart';

class MaterialHero extends StatelessWidget {
  final Widget child;
  final Object tag;

  MaterialHero({
    Key? key,
    required this.child,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: tag,
      child: Material(
        type: MaterialType.transparency,
        child: child,
      ),
    );
  }
}
