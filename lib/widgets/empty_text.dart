import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';

class EmptyText extends StatelessWidget {
  EmptyText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Nothing found.',
      style: BreweryTheme.nothingFound,
    );
  }
}
