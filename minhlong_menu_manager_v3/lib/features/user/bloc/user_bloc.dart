import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../auth/data/model/access_token.dart';
import '../data/model/user_model.dart';
import '../data/repositories/user_repository.dart';
import 'package:meta/meta.dart';
part 'user_event.dart';
part 'user_state.dart';

typedef Emit = Emitter<UserState>;

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc({required UserRepo userRepository})
      : _userRepository = userRepository,
        super(UserInitial()) {
    on<UserFetched>(_onUserFetched);
    on<UserUpdated>(_onUserUpdated);
    on<UserUpdatePasswordStarted>(_onUserUpdatedPassword);
  }
  final UserRepo _userRepository;

  FutureOr<void> _onUserFetched(UserFetched event, Emit emit) async {
    emit(UserFecthInProgress());
    final result = await _userRepository.getUser(
      accessToken: event.accessToken,
    );
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
