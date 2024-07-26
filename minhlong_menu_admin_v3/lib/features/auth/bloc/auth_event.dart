part of 'auth_bloc.dart';

sealed class AuthEvent {}

class AuthEventStarted extends AuthEvent {}

class AuthLoginStarted extends AuthEvent {
  AuthLoginStarted(this.login);
  final LoginDto login;
}

class AuthRegisterStarted extends AuthEvent {}

class AuthAuthenticateStarted extends AuthEvent {}

class AuthLogoutStarted extends AuthEvent {}

final class AuthForgotPasswordStarted extends AuthEvent {
  AuthForgotPasswordStarted(this.login);
  final LoginDto login;
}

class AuthEventRefreshTokenStarted extends AuthEvent {
  AuthEventRefreshTokenStarted(this.refreshToken);
  final String refreshToken;
}
