import 'package:flutter/material.dart';

class FailureText extends StatelessWidget {
  final String message;

  FailureText({Key key, @required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodyText1,
    );
  }
}
