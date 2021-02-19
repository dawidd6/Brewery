import 'package:flutter/material.dart';

class BreweryColors {
  static final Color brown = Color(0xFF2F2A25);
  static final Color brownDark = Color(0xFF211D19);
  static final Color goldLight = Color(0xFFFFCE9B);
  static final Color goldDark = Color(0xFFC5843D);
  static final MaterialColor brownMaterial = MaterialColor(
    brown.value,
    <int, Color>{
      50: brown,
      100: brown,
      200: brown,
      300: brown,
      400: brown,
      500: brown,
      600: brown,
      700: brown,
      800: brown,
      900: brown,
    },
  );
}
