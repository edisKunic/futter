import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  final bool isDarkMode;

  const AppLoaded({this.isDarkMode = false});

  @override
  List<Object?> get props => [isDarkMode];

  AppLoaded copyWith({bool? isDarkMode}) {
    return AppLoaded(isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}
