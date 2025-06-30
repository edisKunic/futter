import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';

import '../../../../shared/services/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiService _apiService = GetIt.instance<ApiService>();

  HomeBloc() : super(HomeInitial()) {
    on<HomeDataRequested>(_onHomeDataRequested);
  }

  Future<void> _onHomeDataRequested(
    HomeDataRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoading());

    try {
      final response = await _apiService.get('/home/data');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        emit(HomeLoaded(data));
      } else {
        emit(HomeError('Failed to load home data'));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
