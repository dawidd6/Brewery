import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  final bool condition;
  final Widget? widgetIfTrue;
  final Widget? widgetIfFalse;

  ConditionalWidget({
    Key? key,
    required this.condition,
    this.widgetIfTrue,
    this.widgetIfFalse,
  });

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return widgetIfTrue ?? Container();
    } else {
      return widgetIfFalse ?? Container();
    }
  }
}
