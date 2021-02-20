import 'package:brewery/styles/theme.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class App extends StatelessWidget {
  final String title = "Brewery";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: BreweryTheme.data,
      home: HomePage(title: title),
    );
  }
}
