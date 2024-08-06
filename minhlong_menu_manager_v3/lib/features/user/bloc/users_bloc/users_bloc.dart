import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../data/model/user.dart';
import '../../data/model/user_model.dart';
import '../../data/repositories/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

typedef Emit = Emitter<UsersState>;

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._userRepository) : super(UsersInitial()) {
    on<UsersFetched>(_onUsersFetched);
    on<UsersDeleted>(_onUsersDeleted);
    on<UsersCreated>(_onUsersCreated);
    on<UsersExtended>(_onUsersExtended);
  }
  final UserRepo _userRepository;

  FutureOr<void> _onUsersFetched(UsersFetched event, Emit emit) async {
    emit(UsersFetchInProgress());
    final result = await _userRepository.getUsers(
      page: event.page,
      limit: event.limit,
    );
    result.when(
      success: (users) {
        if (users.users.isEmpty) {
          emit(UsersFetchEmpty());
        }
        emit(UsersFetchSuccess(users));
      },
      failure: (message) {
        emit(UsersFetchFailure(message));
      },
    );
    return null;
  }

  FutureOr<void> _onUsersDeleted(UsersDeleted event, Emit emit) async {
    emit(UsersDeleteInProgress());
    final result = await _userRepository.deleteUser(id: event.id);
    result.when(
      success: (success) {
        emit(UsersDeleteSuccess());
      },
      failure: (message) {
        emit(UsersDeleteFailure(message));
      },
    );
  }

  FutureOr<void> _onUsersCreated(UsersCreated event, Emit emit) async {
    emit(UsersCreateInProgress());
    final result = await _userRepository.createUser(userModel: event.userModel);
    result.when(
      success: (success) {
        emit(UsersCreateSuccess());
      },
      failure: (message) {
        emit(UsersCreateFailure(message));
      },
    );
  }

  FutureOr<void> _onUsersExtended(UsersExtended event, Emit emit) async {
    emit(UsersExtendedInProgress());
    final result = await _userRepository.extendedUser(
        userID: event.userID, expired: event.expired, extended: event.extended);
    result.when(
      success: (success) {
        emit(UsersExtendedSuccess());
      },
      failure: (message) {
        emit(UsersExtendedFailure(message));
      },
    );
  }
}
