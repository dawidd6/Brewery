import 'package:flutter/material.dart';

class CenterSwitcher extends StatelessWidget {
  final Widget Function(BuildContext context) builder;

  CenterSwitcher({Key key, @required this.builder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 500),
        child: builder(context),
      ),
    );
  }
}
