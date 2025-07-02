import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'base_theme.dart';
import 'themes/ocean_theme.dart';
import 'themes/forest_theme.dart';
import 'themes/sunset_theme.dart';
import '../services/storage_service.dart';

class ThemeManager {
  static final ThemeManager _instance = ThemeManager._internal();
  factory ThemeManager() => _instance;
  ThemeManager._internal() {
    _registerThemes();
    _currentTheme = _themes[_defaultThemeKey];
  }

  StorageService? _storageService;

  static const String _themeStorageKey = 'selected_theme_key';
  static const String _defaultThemeKey = 'ocean';

  final Map<String, BaseTheme> _themes = {};
  BaseTheme? _currentTheme;

  StorageService? get _safeStorageService {
    try {
      if (_storageService == null &&
          GetIt.instance.isRegistered<StorageService>()) {
        _storageService = GetIt.instance<StorageService>();
      }
      return _storageService;
    } catch (e) {
      return null;
    }
  }

  Future<void> initialize() async {
    try {
      final storage = _safeStorageService;
      if (storage != null) {
        final storedThemeKey = await storage.getString(_themeStorageKey);
        if (storedThemeKey != null && _themes.containsKey(storedThemeKey)) {
          _currentTheme = _themes[storedThemeKey];
        }
      }
    } catch (e) {
      // Ignore storage errors, use default theme
    }
  }

  void _registerThemes() {
    _themes.clear();

    final oceanTheme = OceanTheme();
    final forestTheme = ForestTheme();
    final sunsetTheme = SunsetTheme();

    _themes[oceanTheme.themeKey] = oceanTheme;
    _themes[forestTheme.themeKey] = forestTheme;
    _themes[sunsetTheme.themeKey] = sunsetTheme;
  }

  BaseTheme get currentTheme {
    return _currentTheme ?? _themes[_defaultThemeKey]!;
  }

  ThemeData get currentThemeData {
    return currentTheme.themeData;
  }

  String get currentThemeKey {
    return currentTheme.themeKey;
  }

  List<BaseTheme> get availableThemes {
    return _themes.values.toList();
  }

  Map<String, BaseTheme> get themesMap {
    return Map.unmodifiable(_themes);
  }

  Future<bool> switchTheme(String themeKey) async {
    if (!_themes.containsKey(themeKey)) {
      return false;
    }

    _currentTheme = _themes[themeKey];

    try {
      final storage = _safeStorageService;
      if (storage != null) {
        await storage.setString(_themeStorageKey, themeKey);
      }
    } catch (e) {
      // Ignore storage errors
    }

    return true;
  }

  BaseTheme? getThemeByKey(String themeKey) {
    return _themes[themeKey];
  }

  void registerTheme(BaseTheme theme) {
    _themes[theme.themeKey] = theme;
  }

  void unregisterTheme(String themeKey) {
    if (themeKey == _defaultThemeKey) {
      throw Exception('Cannot unregister default theme');
    }

    if (_currentTheme?.themeKey == themeKey) {
      _currentTheme = _themes[_defaultThemeKey];
    }

    _themes.remove(themeKey);
  }

  bool hasTheme(String themeKey) {
    return _themes.containsKey(themeKey);
  }

  Future<void> saveThemeToDatabase(String themeKey) async {
    throw UnimplementedError(
        'Database theme saving will be implemented in the future. '
        'Theme key to save: $themeKey');
  }

  Future<String?> loadThemeFromDatabase(String userId) async {
    throw UnimplementedError(
        'Database theme loading will be implemented in the future. '
        'User ID: $userId');
  }

  Future<void> syncThemeWithUser(String userId) async {
    try {
      final userThemeKey = await loadThemeFromDatabase(userId);
      if (userThemeKey != null && hasTheme(userThemeKey)) {
        await switchTheme(userThemeKey);
      }
    } catch (e) {
      // Theme sync failed, using current theme
    }
  }

  Future<void> saveCurrentThemeToDatabase() async {
    try {
      await saveThemeToDatabase(currentThemeKey);
    } catch (e) {
      // Failed to save theme to database
    }
  }

  Color getCustomColor(String colorKey, {Color? fallback}) {
    final customColors = currentTheme.customColors;
    return customColors[colorKey] ??
        fallback ??
        currentTheme.colorScheme.primary;
  }

  TextStyle getCustomTextStyle(String styleKey, {TextStyle? fallback}) {
    final customStyles = currentTheme.customTextStyles;
    return customStyles[styleKey] ??
        fallback ??
        currentTheme.textTheme.bodyMedium!;
  }

  double getCustomSpacing(String spacingKey, {double? fallback}) {
    final customSpacing = currentTheme.customSpacing;
    return customSpacing[spacingKey] ?? fallback ?? 16.0;
  }

  EdgeInsets getPadding(String type) {
    switch (type.toLowerCase()) {
      case 'small':
        return currentTheme.smallPadding;
      case 'large':
        return currentTheme.largePadding;
      case 'default':
      default:
        return currentTheme.defaultPadding;
    }
  }

  BorderRadius getBorderRadius(String type) {
    switch (type.toLowerCase()) {
      case 'small':
        return currentTheme.smallBorderRadius;
      case 'large':
        return currentTheme.largeBorderRadius;
      case 'default':
      default:
        return currentTheme.defaultBorderRadius;
    }
  }

  double getElevation(String type) {
    switch (type.toLowerCase()) {
      case 'small':
        return currentTheme.smallElevation;
      case 'large':
        return currentTheme.largeElevation;
      case 'default':
      default:
        return currentTheme.defaultElevation;
    }
  }

  List<BoxShadow> getShadow(String type) {
    switch (type.toLowerCase()) {
      case 'small':
        return currentTheme.smallShadow;
      case 'large':
        return currentTheme.largeShadow;
      case 'default':
      default:
        return currentTheme.defaultShadow;
    }
  }

  Gradient? getGradient(String type) {
    switch (type.toLowerCase()) {
      case 'primary':
        return currentTheme.primaryGradient;
      case 'secondary':
        return currentTheme.secondaryGradient;
      case 'background':
        return currentTheme.backgroundGradient;
      default:
        return null;
    }
  }

  void resetToDefault() {
    _currentTheme = _themes[_defaultThemeKey];

    try {
      final storage = _safeStorageService;
      if (storage != null) {
        storage.setString(_themeStorageKey, _defaultThemeKey);
      }
    } catch (e) {
      // Ignore storage errors
    }
  }

  String get themeInfo {
    final theme = currentTheme;
    return '''
Theme: ${theme.themeName}
Key: ${theme.themeKey}
Description: ${theme.themeDescription}
Colors: ${theme.customColors.length} custom colors
Text Styles: ${theme.customTextStyles.length} custom styles
Spacing: ${theme.customSpacing.length} custom spacing values
''';
  }
}
