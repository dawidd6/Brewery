import 'package:brewery/pages/home_page.dart';
import 'package:brewery/styles/brewery_theme.dart';
import 'package:flutter/material.dart';

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
