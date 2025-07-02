part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object?> get props => [];
}

class ThemeInitial extends ThemeState {
  const ThemeInitial();
}

class ThemeLoading extends ThemeState {
  const ThemeLoading();
}

class ThemeLoaded extends ThemeState {
  final BaseTheme currentTheme;
  final List<BaseTheme> availableThemes;

  const ThemeLoaded({
    required this.currentTheme,
    required this.availableThemes,
  });

  @override
  List<Object?> get props => [currentTheme, availableThemes];

  ThemeLoaded copyWith({
    BaseTheme? currentTheme,
    List<BaseTheme>? availableThemes,
  }) {
    return ThemeLoaded(
      currentTheme: currentTheme ?? this.currentTheme,
      availableThemes: availableThemes ?? this.availableThemes,
    );
  }
}

class ThemeChanging extends ThemeState {
  final BaseTheme previousTheme;

  const ThemeChanging(this.previousTheme);

  @override
  List<Object?> get props => [previousTheme];
}

class ThemeError extends ThemeState {
  final String message;

  const ThemeError(this.message);

  @override
  List<Object?> get props => [message];
}
