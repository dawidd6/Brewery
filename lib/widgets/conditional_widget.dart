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

  static Widget? nullable({
    required bool condition,
    Widget? widgetIfTrue,
    Widget? widgetIfFalse,
  }) {
    if (condition) {
      return widgetIfTrue;
    } else {
      return widgetIfFalse;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (condition) {
      return widgetIfTrue ?? Container();
    } else {
      return widgetIfFalse ?? Container();
    }
  }
}
