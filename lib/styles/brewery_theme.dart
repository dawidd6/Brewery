import 'package:brewery/styles/brewery_colors.dart';
import 'package:flutter/material.dart';

class BreweryTheme {
  static final ThemeData data = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: BreweryColors.brown,
    accentColor: BreweryColors.goldDark,
    canvasColor: BreweryColors.brownDark,
    brightness: Brightness.dark,
    appBarTheme: AppBarTheme(
      color: BreweryColors.brown,
      textTheme: TextTheme(
        headline6: TextStyle(
          color: BreweryColors.goldLight,
          fontSize: 20.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      iconTheme: IconThemeData(
        color: BreweryColors.goldLight,
      ),
      actionsIconTheme: IconThemeData(
        color: BreweryColors.goldLight,
      ),
    ),
    scaffoldBackgroundColor: BreweryColors.brown,
    popupMenuTheme: PopupMenuThemeData(
      color: BreweryColors.brown,
    ),
    iconTheme: IconThemeData(
      color: BreweryColors.brownDark,
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: BreweryColors.goldLight,
      ),
      counterStyle: TextStyle(
        color: BreweryColors.goldLight,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: BreweryColors.brownDark,
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: BreweryColors.brownDark,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: BreweryColors.goldDark,
        ),
      ),
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
      // List tile name text
      headline1: TextStyle(
        color: BreweryColors.goldDark,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      // List tile description text
      headline2: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
      ),
      // List tile version text
      headline3: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      ),
      // Error text
      bodyText1: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
      ),
      // Popup menu items text
      bodyText2: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
      // Search bar text
      subtitle1: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
    ),
  );
}
