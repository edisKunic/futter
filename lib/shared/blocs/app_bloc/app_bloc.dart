import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/services/storage_service.dart';
import 'app_event.dart';
import 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final StorageService _storageService = GetIt.instance<StorageService>();

  AppBloc() : super(AppInitial()) {
    on<AppStarted>(_onAppStarted);
    on<AppThemeChanged>(_onAppThemeChanged);
  }

  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AppState> emit,
  ) async {
    emit(AppLoading());
    final isDarkMode = await _storageService.getBool('is_dark_mode') ?? false;
    emit(AppLoaded(isDarkMode: isDarkMode));
  }

  Future<void> _onAppThemeChanged(
    AppThemeChanged event,
    Emitter<AppState> emit,
  ) async {
    await _storageService.setBool('is_dark_mode', event.isDarkMode);
    emit(AppLoaded(isDarkMode: event.isDarkMode));
  }
}
