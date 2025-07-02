part of 'theme_bloc.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object?> get props => [];
}

class ThemeInitializeRequested extends ThemeEvent {
  const ThemeInitializeRequested();
}

class ThemeChangeRequested extends ThemeEvent {
  final String themeKey;

  const ThemeChangeRequested(this.themeKey);

  @override
  List<Object?> get props => [themeKey];
}

class ThemeResetRequested extends ThemeEvent {
  const ThemeResetRequested();
}

class ThemeSyncWithUserRequested extends ThemeEvent {
  final String userId;

  const ThemeSyncWithUserRequested(this.userId);

  @override
  List<Object?> get props => [userId];
}

class ThemeSaveToDatabaseRequested extends ThemeEvent {
  const ThemeSaveToDatabaseRequested();
}
