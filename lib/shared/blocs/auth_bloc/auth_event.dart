import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthCheckRequested extends AuthEvent {}

class AuthLoggedIn extends AuthEvent {
  final String token;
  final String refreshToken;
  final DateTime accessTokenExpiry;
  final DateTime refreshTokenExpiry;

  const AuthLoggedIn({
    required this.token,
    required this.refreshToken,
    required this.accessTokenExpiry,
    required this.refreshTokenExpiry,
  });

  @override
  List<Object?> get props =>
      [token, refreshToken, accessTokenExpiry, refreshTokenExpiry];
}

class AuthLoggedOut extends AuthEvent {}
