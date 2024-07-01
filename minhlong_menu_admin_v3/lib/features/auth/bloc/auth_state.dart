part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoginInProgress extends AuthState {}

final class AuthLoginSuccess extends AuthState {}

final class AuthLoginFailure extends AuthState {
  AuthLoginFailure(this.message);

  final String message;
}

final class AuthAuthenticateSuccess extends AuthState {
  final AccessToken accessToken;

  AuthAuthenticateSuccess(this.accessToken);
}

final class AuthAuthenticateUnauthenticated extends AuthState {}

final class AuthAuthenticateFailure extends AuthState {
  AuthAuthenticateFailure(this.message);

  final String message;
}

final class AuthLogoutSuccess extends AuthState {}

final class AuthLogoutFailure extends AuthState {
  AuthLogoutFailure(this.message);

  final String message;
}
