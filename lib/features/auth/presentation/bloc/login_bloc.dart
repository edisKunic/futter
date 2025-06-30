import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';

import '../../../../shared/services/api_service.dart';
import '../../../../shared/blocs/auth_bloc/auth_bloc.dart';
import '../../../../shared/blocs/auth_bloc/auth_event.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final ApiService _apiService = GetIt.instance<ApiService>();
  final AuthBloc _authBloc;

  LoginBloc(this._authBloc) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    try {
      final response = await _apiService.post('/auth/login', {
        'email': event.email,
        'password': event.password,
      });

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'] as String;

        _authBloc.add(AuthLoggedIn(token));
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Login failed'));
      }
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
