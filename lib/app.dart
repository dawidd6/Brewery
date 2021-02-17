import 'package:flutter/material.dart';

import 'colors.dart';
import 'pages/home.dart';

class BreweryApp extends StatelessWidget {
  final String title = "Brewery";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        dividerTheme: DividerThemeData(
          color: BreweryColors.brownDark,
        ),
        primarySwatch: BreweryColors.brownMaterial,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: BreweryColors.brown,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: BreweryColors.brown,
          selectedItemColor: BreweryColors.goldLight,
          unselectedItemColor: BreweryColors.brownDark,
        ),
        textTheme: TextTheme(
          headline1: TextStyle(
            color: BreweryColors.goldLight,
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      home: BreweryHomePage(title: title),
    );
  }
}
