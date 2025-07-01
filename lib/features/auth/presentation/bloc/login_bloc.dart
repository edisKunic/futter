import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';

import '../../../../shared/blocs/auth_bloc/auth_bloc.dart';
import '../../../../shared/blocs/auth_bloc/auth_event.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthBloc _authBloc;

  LoginBloc(this._authBloc) : super(LoginInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());

    await Future.delayed(const Duration(seconds: 2));

    if (event.email == 'user@example.com' && event.password == 'password123') {
      final accessToken =
          'mock_access_token_${DateTime.now().millisecondsSinceEpoch}';
      final refreshToken =
          'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}';
      final accessTokenExpiry = DateTime.now().add(const Duration(hours: 1));
      final refreshTokenExpiry = DateTime.now().add(const Duration(days: 7));

      _authBloc.add(AuthLoggedIn(
        token: accessToken,
        refreshToken: refreshToken,
        accessTokenExpiry: accessTokenExpiry,
        refreshTokenExpiry: refreshTokenExpiry,
      ));
      emit(LoginSuccess());
    } else {
      emit(const LoginFailure('Invalid email or password'));
    }
  }
}
