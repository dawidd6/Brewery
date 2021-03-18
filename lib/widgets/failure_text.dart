import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';

class FailureText extends StatelessWidget {
  final String message;

  FailureText({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: BreweryTheme.failureText,
    );
  }
}
