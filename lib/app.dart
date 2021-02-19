import 'package:brewery/styles/theme.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';

class BreweryApp extends StatelessWidget {
  final String title = "Brewery";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: BreweryTheme.data,
      home: BreweryHomePage(title: title),
    );
  }
}
