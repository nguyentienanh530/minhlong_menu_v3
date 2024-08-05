import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/user.dart';
import '../data/repositories/user_repository.dart';

part 'users_event.dart';
part 'users_state.dart';

typedef Emit = Emitter<UsersState>;

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc(this._userRepository) : super(UsersInitial()) {
    on<UsersFetched>(_onUsersFetched);
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
}
