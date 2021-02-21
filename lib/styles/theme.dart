import 'package:brewery/styles/colors.dart';
import 'package:flutter/material.dart';

class BreweryTheme {
  static final ThemeData data = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: BreweryColors.brown,
    appBarTheme: AppBarTheme(
        color: BreweryColors.brown,
        textTheme: TextTheme(
          headline6: TextStyle(
            color: BreweryColors.goldLight,
            fontSize: 20.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        actionsIconTheme: IconThemeData(
          color: BreweryColors.goldLight,
        )),
    scaffoldBackgroundColor: BreweryColors.brown,
    popupMenuTheme: PopupMenuThemeData(
      color: BreweryColors.brown,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: BreweryColors.brownDark,
      ),
    ),
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
    ),
  );
}
