import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final Object object;
  final Map<Type, Widget Function(BuildContext)> switchBuilders;
  final Widget Function(BuildContext) fallbackBuilder;

  SwitchWidget({
    Key? key,
    required this.object,
    required this.switchBuilders,
    required this.fallbackBuilder,
  });

  @override
  Widget build(BuildContext context) {
    for (final entry in switchBuilders.entries) {
      if (object.runtimeType == entry.key) {
        return entry.value(context);
      }
    }
    return fallbackBuilder(context);
  }
}
