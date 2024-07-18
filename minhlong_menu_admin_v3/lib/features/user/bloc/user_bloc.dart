import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/repositories/user_repository.dart';

import '../data/model/user_model.dart';

part 'user_event.dart';
part 'user_state.dart';

typedef Emit = Emitter<UserState>;

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    on<UserFetched>(_onUserFetched);
    on<UserUpdated>(_onUserUpdated);
    on<UserUpdatePasswordStarted>(_onUserUpdatedPassword);
  }
  final UserRepository _userRepository;

  FutureOr<void> _onUserFetched(UserFetched event, Emit emit) async {
    emit(UserFecthInProgress());
    final result = await _userRepository.getUser();
    result.when(
      success: (user) {
        emit(UserFecthSuccess(user));
      },
      failure: (message) {
        emit(UserFecthFailure(message));
      },
    );
  }

  FutureOr<void> _onUserUpdated(UserUpdated event, Emit emit) async {
    emit(UserUpdateInProgress());
    final result = await _userRepository.updateUser(userModel: event.userModel);
    result.when(
      success: (success) {
        emit(UserUpdateSuccess());
      },
      failure: (message) {
        emit(UserUpdateFailure(message));
      },
    );
  }

  FutureOr<void> _onUserUpdatedPassword(
      UserUpdatePasswordStarted event, Emit emit) async {
    emit(UserUpdatePasswordInProgress());
    final result = await _userRepository.updatePassword(
        oldPassword: event.oldPassword, newPassword: event.newPassword);
    result.when(
      success: (success) {
        emit(UserUpdatePasswordSuccess());
      },
      failure: (message) {
        emit(UserUpdatePasswordFailure(message));
      },
    );
  }
}
