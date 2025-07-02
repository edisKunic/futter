import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/theme/theme_manager.dart';
import '../../../core/theme/base_theme.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final ThemeManager _themeManager = ThemeManager();

  ThemeBloc()
      : super(ThemeLoaded(
          currentTheme: ThemeManager().currentTheme,
          availableThemes: ThemeManager().availableThemes,
        )) {
    on<ThemeInitializeRequested>(_onThemeInitializeRequested);
    on<ThemeChangeRequested>(_onThemeChangeRequested);
    on<ThemeResetRequested>(_onThemeResetRequested);
    on<ThemeSyncWithUserRequested>(_onThemeSyncWithUserRequested);
    on<ThemeSaveToDatabaseRequested>(_onThemeSaveToDatabaseRequested);
  }

  Future<void> _onThemeInitializeRequested(
    ThemeInitializeRequested event,
    Emitter<ThemeState> emit,
  ) async {
    // No async work needed - already initialized
    emit(ThemeLoaded(
      currentTheme: _themeManager.currentTheme,
      availableThemes: _themeManager.availableThemes,
    ));
  }

  Future<void> _onThemeChangeRequested(
    ThemeChangeRequested event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) return;

    final currentState = state as ThemeLoaded;
    emit(ThemeChanging(currentState.currentTheme));

    try {
      final success = await _themeManager.switchTheme(event.themeKey);

      if (success) {
        emit(ThemeLoaded(
          currentTheme: _themeManager.currentTheme,
          availableThemes: _themeManager.availableThemes,
        ));
      } else {
        emit(ThemeError('Theme "${event.themeKey}" not found'));
        emit(currentState);
      }
    } catch (e) {
      emit(ThemeError('Failed to change theme: ${e.toString()}'));
      emit(currentState);
    }
  }

  Future<void> _onThemeResetRequested(
    ThemeResetRequested event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) return;

    try {
      _themeManager.resetToDefault();
      emit(ThemeLoaded(
        currentTheme: _themeManager.currentTheme,
        availableThemes: _themeManager.availableThemes,
      ));
    } catch (e) {
      emit(ThemeError('Failed to reset theme: ${e.toString()}'));
    }
  }

  Future<void> _onThemeSyncWithUserRequested(
    ThemeSyncWithUserRequested event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) return;

    final currentState = state as ThemeLoaded;

    try {
      await _themeManager.syncThemeWithUser(event.userId);
      emit(ThemeLoaded(
        currentTheme: _themeManager.currentTheme,
        availableThemes: _themeManager.availableThemes,
      ));
    } catch (e) {
      emit(ThemeError('Failed to sync theme with user: ${e.toString()}'));
      emit(currentState);
    }
  }

  Future<void> _onThemeSaveToDatabaseRequested(
    ThemeSaveToDatabaseRequested event,
    Emitter<ThemeState> emit,
  ) async {
    if (state is! ThemeLoaded) return;

    final currentState = state as ThemeLoaded;

    try {
      await _themeManager.saveCurrentThemeToDatabase();
    } catch (e) {
      emit(ThemeError('Failed to save theme to database: ${e.toString()}'));
      emit(currentState);
    }
  }
}
