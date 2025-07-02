import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState();

  @override
  List<Object?> get props => [];
}

class AppInitial extends AppState {}

class AppLoading extends AppState {}

class AppLoaded extends AppState {
  const AppLoaded();

  @override
  List<Object?> get props => [];
}
