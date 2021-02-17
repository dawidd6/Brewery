import 'package:flutter/material.dart';

import 'colors.dart';
import 'home_page.dart';

class BreweryApp extends StatelessWidget {
  final String title = "Brewery";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
          primarySwatch: BreweryColors.brownMaterial,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          scaffoldBackgroundColor: BreweryColors.brown,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: BreweryColors.brown,
            selectedItemColor: BreweryColors.goldLight,
            unselectedItemColor: BreweryColors.brownDark,
          )),
      home: BreweryHomePage(title: title),
    );
  }
}
