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
