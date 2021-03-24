import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';

class FailureText extends StatelessWidget {
  final Object error;

  FailureText({
    Key? key,
    required this.error,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'An error occurred while fetching data.',
      style: BreweryTheme.failureText,
    );
  }
}
