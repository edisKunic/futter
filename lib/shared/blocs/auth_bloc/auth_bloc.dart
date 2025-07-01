import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../core/services/token_service.dart';
import '../../../core/models/token_model.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final TokenService _tokenService = GetIt.instance<TokenService>();

  AuthBloc() : super(AuthInitial()) {
    on<AuthCheckRequested>(_onAuthCheckRequested);
    on<AuthLoggedIn>(_onAuthLoggedIn);
    on<AuthLoggedOut>(_onAuthLoggedOut);
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final isValid = await _tokenService.isTokenValid();
    if (isValid) {
      final tokens = await _tokenService.getTokens();
      emit(Authenticated(tokens!.accessToken));
    } else {
      emit(Unauthenticated());
    }
  }

  Future<void> _onAuthLoggedIn(
    AuthLoggedIn event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    final tokens = TokenModel(
      accessToken: event.token,
      refreshToken: event.refreshToken,
      accessTokenExpiry: event.accessTokenExpiry,
      refreshTokenExpiry: event.refreshTokenExpiry,
    );
    await _tokenService.saveTokens(tokens);
    emit(Authenticated(event.token));
  }

  Future<void> _onAuthLoggedOut(
    AuthLoggedOut event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    await _tokenService.clearTokens();
    emit(Unauthenticated());
  }
}
