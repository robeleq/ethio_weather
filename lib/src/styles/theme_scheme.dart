import 'package:flutter/material.dart';

import 'colors.dart';

class ThemeScheme {
  static const int THEME_LIGHT = 0;
  static const int THEME_DARK = 1;

  static ThemeData lightTheme() {
    return ThemeData(
        brightness: Brightness.light,
        fontFamily: 'Poppins',
        primaryColor: lPrimaryLightColor,
        scaffoldBackgroundColor: lPrimaryBackgroundColor,
        // backgroundColor: lPrimaryBackgroundColor,
        focusColor: lPrimaryTextColor,
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: lPrimaryLightColor),
        ),
        inputDecorationTheme:
            const InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide(color: lSecondaryLightColor))),
        iconTheme: const IconThemeData(color: lPrimaryDarkColor),
        cardTheme: const CardTheme(color: lSecondaryLightColor),
        colorScheme: const ColorScheme.light().copyWith(
          surface: lPrimaryBackgroundColor, // Custom background color
        ),
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      brightness: Brightness.dark,
      fontFamily: 'Poppins',
      primaryColor: dPrimaryDarkColor,
      scaffoldBackgroundColor: dPrimaryBackgroundColor,
      // backgroundColor: dPrimaryBackgroundColor,
      focusColor: dPrimaryTextColor,
      primarySwatch: Colors.blue,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(color: dPrimaryDarkColor),
      ),
      inputDecorationTheme:
          const InputDecorationTheme(border: OutlineInputBorder(borderSide: BorderSide(color: dSecondaryDarkColor))),
      iconTheme: const IconThemeData(color: dPrimaryLightColor),
      cardTheme: const CardTheme(color: dSecondaryDarkColor),
      colorScheme: const ColorScheme.dark().copyWith(
        surface: dPrimaryBackgroundColor, // Custom background color
      ),
    );
  }
}
