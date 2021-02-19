import 'package:flutter/material.dart';

import 'colors.dart';

class BreweryTheme {
  static final ThemeData data = ThemeData(
    primarySwatch: BreweryColors.brownMaterial,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: BreweryColors.brown,
    backgroundColor: BreweryColors.goldDark,
    iconTheme: IconThemeData(
      color: BreweryColors.brownDark,
      size: 128.0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: BreweryColors.brown,
      selectedItemColor: BreweryColors.goldLight,
      unselectedItemColor: BreweryColors.brownDark,
    ),
    dividerTheme: DividerThemeData(
      color: BreweryColors.brownDark,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: BreweryColors.goldDark,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      headline2: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      headline3: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      ),
      bodyText1: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
