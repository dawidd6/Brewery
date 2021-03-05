import 'package:brewery/styles/brewery_colors.dart';
import 'package:flutter/material.dart';

class BreweryTheme {
  static final ThemeData data = ThemeData(
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: BreweryColors.brown,
    accentColor: BreweryColors.goldDark,
    canvasColor: BreweryColors.brownDark,
    backgroundColor: BreweryColors.brownDark,
    toggleableActiveColor: BreweryColors.goldDark,
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
      isDense: true,
      filled: true,
      fillColor: BreweryColors.brownDark,
      labelStyle: TextStyle(
        color: BreweryColors.goldDark,
      ),
      hintStyle: TextStyle(
        color: BreweryColors.brown,
      ),
      counterStyle: TextStyle(
        color: BreweryColors.goldDark,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        borderSide: BorderSide(
          color: BreweryColors.brownDark,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
        borderSide: BorderSide(
          color: BreweryColors.brownDark,
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
    chipTheme: ChipThemeData.fromDefaults(
      primaryColor: BreweryColors.goldLight,
      secondaryColor: BreweryColors.brownDark,
      labelStyle: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: BreweryColors.goldDark,
    ),
    textTheme: TextTheme(
      // List tile name text
      headline1: TextStyle(
        color: BreweryColors.goldDark,
        fontSize: 16.0,
        fontWeight: FontWeight.w500,
      ),
      // List tile name highlighted text
      headline6: TextStyle(
        color: BreweryColors.brown,
        fontSize: 16.0,
        backgroundColor: BreweryColors.goldDark,
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
      // Details headline text
      headline4: TextStyle(
        color: BreweryColors.goldDark,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
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
