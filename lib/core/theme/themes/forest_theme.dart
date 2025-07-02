import 'package:flutter/material.dart';
import '../base_theme.dart';

class ForestTheme extends BaseTheme {
  @override
  String get themeKey => 'forest';

  @override
  String get themeName => 'Forest';

  @override
  String get themeDescription =>
      'Nature-inspired green theme with earthy tones';

  @override
  ColorScheme get colorScheme => const ColorScheme.light(
        brightness: Brightness.light,
        primary: Color(0xFF2E7D32),
        onPrimary: Color(0xFFFFFFFF),
        primaryContainer: Color(0xFFC8E6C9),
        onPrimaryContainer: Color(0xFF1B5E20),
        secondary: Color(0xFF66BB6A),
        onSecondary: Color(0xFF000000),
        secondaryContainer: Color(0xFFDCEDC8),
        onSecondaryContainer: Color(0xFF33691E),
        tertiary: Color(0xFF8BC34A),
        onTertiary: Color(0xFF000000),
        tertiaryContainer: Color(0xFFF1F8E9),
        onTertiaryContainer: Color(0xFF689F38),
        error: Color(0xFFD32F2F),
        onError: Color(0xFFFFFFFF),
        errorContainer: Color(0xFFFFDAD6),
        onErrorContainer: Color(0xFF410002),
        surface: Color(0xFFFAFAFA),
        onSurface: Color(0xFF1C1B1F),
        surfaceContainerHighest: Color(0xFFE8F5E8),
        outline: Color(0xFF81C784),
        outlineVariant: Color(0xFFC8E6C9),
      );

  @override
  ThemeData get themeData => ThemeData(
        useMaterial3: true,
        colorScheme: colorScheme,
        textTheme: textTheme,
        appBarTheme: appBarTheme,
        elevatedButtonTheme: elevatedButtonTheme,
        textButtonTheme: textButtonTheme,
        outlinedButtonTheme: outlinedButtonTheme,
        inputDecorationTheme: inputDecorationTheme,
        cardTheme: cardTheme,
        bottomNavigationBarTheme: bottomNavigationBarTheme,
        floatingActionButtonTheme: floatingActionButtonTheme,
        snackBarTheme: snackBarTheme,
        dialogTheme: dialogTheme,
      );

  @override
  AppBarTheme get appBarTheme => AppBarTheme(
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge,
      );

  @override
  ElevatedButtonThemeData get elevatedButtonTheme => ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: defaultElevation,
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
          padding: defaultPadding,
        ),
      );

  @override
  TextButtonThemeData get textButtonTheme => TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
          padding: defaultPadding,
        ),
      );

  @override
  OutlinedButtonThemeData get outlinedButtonTheme => OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colorScheme.primary,
          side: BorderSide(color: colorScheme.outline),
          shape: RoundedRectangleBorder(
            borderRadius: defaultBorderRadius,
          ),
          padding: defaultPadding,
        ),
      );

  @override
  InputDecorationTheme get inputDecorationTheme => InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest.withOpacity(0.5),
        border: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
          borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: defaultBorderRadius,
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        contentPadding: defaultPadding,
      );

  @override
  CardThemeData get cardTheme => CardThemeData(
        color: colorScheme.surface,
        elevation: defaultElevation,
        shape: RoundedRectangleBorder(
          borderRadius: defaultBorderRadius,
        ),
      );

  @override
  BottomNavigationBarThemeData get bottomNavigationBarTheme =>
      BottomNavigationBarThemeData(
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: colorScheme.onSurface.withOpacity(0.6),
        type: BottomNavigationBarType.fixed,
      );

  @override
  FloatingActionButtonThemeData get floatingActionButtonTheme =>
      FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: largeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: largeBorderRadius,
        ),
      );

  @override
  SnackBarThemeData get snackBarTheme => SnackBarThemeData(
        backgroundColor: colorScheme.inverseSurface,
        contentTextStyle: TextStyle(color: colorScheme.onInverseSurface),
        shape: RoundedRectangleBorder(
          borderRadius: smallBorderRadius,
        ),
      );

  @override
  DialogThemeData get dialogTheme => DialogThemeData(
        backgroundColor: colorScheme.surface,
        elevation: largeElevation,
        shape: RoundedRectangleBorder(
          borderRadius: largeBorderRadius,
        ),
      );

  @override
  TextTheme get textTheme => const TextTheme(
        displayLarge: TextStyle(
            fontSize: 57,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        displayMedium: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        displaySmall: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        headlineLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        headlineMedium: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        headlineSmall: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        titleMedium: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1B1F)),
        titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1B1F)),
        bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color(0xFF1C1B1F)),
        labelLarge: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1B1F)),
        labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1B1F)),
        labelSmall: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: Color(0xFF1C1B1F)),
      );

  @override
  EdgeInsets get defaultPadding => const EdgeInsets.all(16.0);

  @override
  EdgeInsets get smallPadding => const EdgeInsets.all(8.0);

  @override
  EdgeInsets get largePadding => const EdgeInsets.all(24.0);

  @override
  BorderRadius get defaultBorderRadius => BorderRadius.circular(12.0);

  @override
  BorderRadius get smallBorderRadius => BorderRadius.circular(8.0);

  @override
  BorderRadius get largeBorderRadius => BorderRadius.circular(16.0);

  @override
  double get defaultElevation => 2.0;

  @override
  double get smallElevation => 1.0;

  @override
  double get largeElevation => 4.0;

  @override
  List<BoxShadow> get defaultShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          offset: const Offset(0, 2),
          blurRadius: 4,
        ),
      ];

  @override
  List<BoxShadow> get smallShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          offset: const Offset(0, 1),
          blurRadius: 2,
        ),
      ];

  @override
  List<BoxShadow> get largeShadow => [
        BoxShadow(
          color: Colors.black.withOpacity(0.15),
          offset: const Offset(0, 4),
          blurRadius: 8,
        ),
      ];

  @override
  Gradient get primaryGradient => LinearGradient(
        colors: [colorScheme.primary, Color(0xFF4CAF50)],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  @override
  Gradient get secondaryGradient => LinearGradient(
        colors: [colorScheme.secondary, colorScheme.tertiary],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      );

  @override
  Gradient? get backgroundGradient => LinearGradient(
        colors: [
          colorScheme.surface,
          colorScheme.primaryContainer.withOpacity(0.1),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      );

  @override
  Map<String, Color> get customColors => {
        'success': const Color(0xFF4CAF50),
        'warning': const Color(0xFFFF9800),
        'info': const Color(0xFF81C784),
        'accent': const Color(0xFF8BC34A),
      };

  @override
  Map<String, TextStyle> get customTextStyles => {
        'button': TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: colorScheme.onPrimary,
        ),
        'headline': TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: colorScheme.onSurface,
        ),
        'caption': TextStyle(
          fontSize: 12,
          color: colorScheme.onSurface.withOpacity(0.6),
        ),
      };

  @override
  Map<String, double> get customSpacing => {
        'xs': 4.0,
        'sm': 8.0,
        'md': 16.0,
        'lg': 24.0,
        'xl': 32.0,
      };
}
