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
    cardTheme: CardTheme(
      color: BreweryColors.brownDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.0),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: BreweryColors.brownDark,
        shape: StadiumBorder(),
        shadowColor: Colors.transparent,
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: BreweryColors.brown,
    ),
    iconTheme: IconThemeData(
      color: BreweryColors.goldDark,
    ),
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: MaterialStateProperty.all(BreweryColors.goldDark),
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
        fontSize: 13.0,
        color: BreweryColors.goldDark,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
        borderSide: BorderSide(
          color: BreweryColors.brownDark,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100.0),
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
      secondaryColor: BreweryColors.goldDark,
      labelStyle: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: BreweryColors.goldDark,
    ),
    // TODO move those below into static methods
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
      // List tile description highlighted text
      overline: TextStyle(
        color: BreweryColors.brown,
        fontSize: 14.0,
        backgroundColor: BreweryColors.goldLight,
        fontWeight: FontWeight.w400,
      ),
      // List tile version text
      headline3: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 13.0,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
      ),
      // Details headline text
      headline4: TextStyle(
        color: BreweryColors.goldDark,
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
      ),
      // Home card text
      headline5: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 24.0,
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
      // Clickable link text
      subtitle2: TextStyle(
        color: BreweryColors.goldLight,
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        decoration: TextDecoration.underline,
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
