import 'package:flutter/material.dart';

abstract class BaseTheme {
  String get themeKey;
  String get themeName;
  String get themeDescription;

  ThemeData get themeData;

  ColorScheme get colorScheme;

  AppBarTheme get appBarTheme;
  ElevatedButtonThemeData get elevatedButtonTheme;
  TextButtonThemeData get textButtonTheme;
  OutlinedButtonThemeData get outlinedButtonTheme;
  InputDecorationTheme get inputDecorationTheme;
  CardThemeData get cardTheme;
  BottomNavigationBarThemeData get bottomNavigationBarTheme;
  FloatingActionButtonThemeData get floatingActionButtonTheme;
  SnackBarThemeData get snackBarTheme;
  DialogThemeData get dialogTheme;

  TextTheme get textTheme;

  EdgeInsets get defaultPadding;
  EdgeInsets get smallPadding;
  EdgeInsets get largePadding;

  BorderRadius get defaultBorderRadius;
  BorderRadius get smallBorderRadius;
  BorderRadius get largeBorderRadius;

  double get defaultElevation;
  double get smallElevation;
  double get largeElevation;

  List<BoxShadow> get defaultShadow;
  List<BoxShadow> get smallShadow;
  List<BoxShadow> get largeShadow;

  Gradient get primaryGradient;
  Gradient get secondaryGradient;
  Gradient? get backgroundGradient;

  Map<String, Color> get customColors;
  Map<String, TextStyle> get customTextStyles;
  Map<String, double> get customSpacing;
}
