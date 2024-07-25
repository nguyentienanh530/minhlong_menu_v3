part of 'auth_bloc.dart';

sealed class AuthState {
  final AccessToken accessToken;
  AuthState(this.accessToken);
}

final class AuthInitial extends AuthState {
  AuthInitial() : super(AccessToken());
}

final class AuthLoginInProgress extends AuthState {
  AuthLoginInProgress() : super(AccessToken());
}

final class AuthLoginSuccess extends AuthState {
  AuthLoginSuccess() : super(AccessToken());
}

final class AuthLoginFailure extends AuthState {
  AuthLoginFailure(this.message) : super(AccessToken());

  final String message;
}

final class AuthAuthenticateSuccess extends AuthState {
  AuthAuthenticateSuccess(super.accessToken);
}

final class AuthAuthenticateUnauthenticated extends AuthState {
  AuthAuthenticateUnauthenticated() : super(AccessToken());
}

final class AuthAuthenticateFailure extends AuthState {
  AuthAuthenticateFailure(this.message) : super(AccessToken());

  final String message;
}

final class AuthLogoutSuccess extends AuthState {
  AuthLogoutSuccess() : super(AccessToken());
}

final class AuthLogoutFailure extends AuthState {
  AuthLogoutFailure(this.message) : super(AccessToken());

  final String message;
}

final class AuthForgotPasswordInProgress extends AuthState {
  AuthForgotPasswordInProgress() : super(AccessToken());
}

final class AuthForgotPasswordSuccess extends AuthState {
  AuthForgotPasswordSuccess() : super(AccessToken());
}

final class AuthForgotPasswordFailure extends AuthState {
  AuthForgotPasswordFailure(this.message) : super(AccessToken());

  final String message;
}
