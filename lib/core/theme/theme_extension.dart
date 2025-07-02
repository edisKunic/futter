import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'theme_manager.dart';
import 'base_theme.dart';
import '../../shared/blocs/theme_bloc/theme_bloc.dart';

extension ThemeExtension on BuildContext {
  ThemeManager get themeManager => ThemeManager();

  BaseTheme get customTheme => themeManager.currentTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color customColor(String colorKey, {Color? fallback}) {
    return themeManager.getCustomColor(colorKey, fallback: fallback);
  }

  TextStyle customTextStyle(String styleKey, {TextStyle? fallback}) {
    return themeManager.getCustomTextStyle(styleKey, fallback: fallback);
  }

  double customSpacing(String spacingKey, {double? fallback}) {
    return themeManager.getCustomSpacing(spacingKey, fallback: fallback);
  }

  EdgeInsets padding(String type) {
    return themeManager.getPadding(type);
  }

  BorderRadius borderRadius(String type) {
    return themeManager.getBorderRadius(type);
  }

  double elevation(String type) {
    return themeManager.getElevation(type);
  }

  List<BoxShadow> shadow(String type) {
    return themeManager.getShadow(type);
  }

  Gradient? gradient(String type) {
    return themeManager.getGradient(type);
  }

  void changeTheme(String themeKey) {
    read<ThemeBloc>().add(ThemeChangeRequested(themeKey));
  }

  void resetTheme() {
    read<ThemeBloc>().add(const ThemeResetRequested());
  }

  EdgeInsets get smallPadding => customTheme.smallPadding;
  EdgeInsets get defaultPadding => customTheme.defaultPadding;
  EdgeInsets get largePadding => customTheme.largePadding;

  BorderRadius get smallBorderRadius => customTheme.smallBorderRadius;
  BorderRadius get defaultBorderRadius => customTheme.defaultBorderRadius;
  BorderRadius get largeBorderRadius => customTheme.largeBorderRadius;

  double get smallElevation => customTheme.smallElevation;
  double get defaultElevation => customTheme.defaultElevation;
  double get largeElevation => customTheme.largeElevation;

  List<BoxShadow> get smallShadow => customTheme.smallShadow;
  List<BoxShadow> get defaultShadow => customTheme.defaultShadow;
  List<BoxShadow> get largeShadow => customTheme.largeShadow;

  Gradient get primaryGradient => customTheme.primaryGradient;
  Gradient get secondaryGradient => customTheme.secondaryGradient;
  Gradient? get backgroundGradient => customTheme.backgroundGradient;

  Map<String, Color> get customColors => customTheme.customColors;
  Map<String, TextStyle> get customTextStyles => customTheme.customTextStyles;
  Map<String, double> get customSpacingValues => customTheme.customSpacing;
}
