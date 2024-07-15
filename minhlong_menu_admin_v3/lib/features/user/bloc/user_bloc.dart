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
}
