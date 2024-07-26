import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/dto/login_dto.dart';
import '../data/model/access_token.dart';
import '../data/respositories/auth_repository.dart';
part 'auth_event.dart';
part 'auth_state.dart';

typedef Emit = Emitter<AuthState>;

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEventStarted>(_onEventStarted);
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthAuthenticateStarted>(_onAuthenticateStarted);
    on<AuthLogoutStarted>(_onLogoutStarted);
    on<AuthForgotPasswordStarted>(_onAuthForgotPasswordStarted);
    on<AuthEventRefreshTokenStarted>(_onAuthEventRefreshTokenStarted);
  }

  final AuthRepository authRepository;

  FutureOr<void> _onLoginStarted(AuthLoginStarted event, Emit emit) async {
    emit(AuthLoginInProgress());
    final result = await authRepository.login(event.login);
    result.when(
      failure: (String failure) {
        emit(AuthLoginFailure(failure));
      },
      success: (_) {
        emit(AuthLoginSuccess());
      },
    );
  }

  FutureOr<void> _onEventStarted(AuthEventStarted event, Emit emit) {
    emit(AuthAuthenticateUnauthenticated());
  }

  FutureOr<void> _onAuthenticateStarted(
      AuthAuthenticateStarted event, Emit emit) async {
    final accessToken = await authRepository.getToken();
    accessToken.when(success: (accessToken) {
      if (accessToken != null) {
        emit(AuthAuthenticateSuccess(accessToken));
      } else {
        emit(AuthAuthenticateUnauthenticated());
      }
    }, failure: (String failure) {
      emit(AuthAuthenticateFailure(failure));
    });
  }

  FutureOr<void> _onLogoutStarted(AuthLogoutStarted event, Emit emit) async {
    final result = await authRepository.logout();
    result.when(
      failure: (String failure) {
        emit(AuthLogoutFailure(failure));
      },
      success: (_) {
        emit(AuthLogoutSuccess());
      },
    );
  }

  FutureOr<void> _onAuthForgotPasswordStarted(
      AuthForgotPasswordStarted event, Emit emit) async {
    emit(AuthForgotPasswordInProgress());
    final result = await authRepository.forgotPassword(login: event.login);
    result.when(failure: (String failure) {
      emit(AuthForgotPasswordFailure(failure));
    }, success: (_) {
      emit(AuthForgotPasswordSuccess());
    });
  }

  FutureOr<void> _onAuthEventRefreshTokenStarted(
      AuthEventRefreshTokenStarted event, Emit emit) async {
    emit(AuthRefreshTokenInProgress());
    final result =
        await authRepository.refreshToken(refreshToken: event.refreshToken);
    result.when(
      failure: (String failure) {
        emit(AuthRefreshTokenFailure(failure));
      },
      success: (token) {
        emit(AuthRefreshTokenSuccess(token));
      },
    );
  }
}
