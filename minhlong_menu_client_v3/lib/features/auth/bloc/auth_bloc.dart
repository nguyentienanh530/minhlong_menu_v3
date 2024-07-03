import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/dto/login_dto.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/respositories/auth_repository.dart';

import '../data/model/access_token.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc(this.authRepository) : super(AuthInitial()) {
    on<AuthEventStarted>(_onEventStarted);
    on<AuthLoginStarted>(_onLoginStarted);
    on<AuthAuthenticateStarted>(_onAuthenticateStarted);
    on<AuthLogoutStarted>(_onLogoutStarted);
  }

  final AuthRepository authRepository;

  FutureOr<void> _onLoginStarted(
      AuthLoginStarted event, Emitter<AuthState> emit) async {
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

  FutureOr<void> _onEventStarted(
      AuthEventStarted event, Emitter<AuthState> emit) {
    emit(AuthAuthenticateUnauthenticated());
  }

  FutureOr<void> _onAuthenticateStarted(
      AuthAuthenticateStarted event, Emitter<AuthState> emit) async {
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

  FutureOr<void> _onLogoutStarted(
      AuthLogoutStarted event, Emitter<AuthState> emit) async {
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
}