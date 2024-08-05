import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/repositories/user_repository.dart';
import '../../data/model/user_model.dart';
part 'search_user_event.dart';
part 'search_user_state.dart';

class SearchUserBloc extends Bloc<SearchUserEvent, SearchUserState> {
  final UserRepo userRepo;
  SearchUserBloc(this.userRepo) : super(SearchUserInitial()) {
    on<SearchUserStarted>(_onSearchUserStarted);
    on<SearchUserReset>(_onSearchUserReset);
  }

  FutureOr<void> _onSearchUserStarted(
      SearchUserStarted event, Emitter<SearchUserState> emit) async {
    emit(SearchUserInProgress());
    final result = await userRepo.searchUser(query: event.query);
    result.when(success: (users) {
      if (users.isEmpty) {
        emit(SearchUserEmpty());
      }
      emit(SearchUserSuccess(users: users));
    }, failure: (message) {
      emit(SearchUserFailure(message: message));
    });
  }

  FutureOr<void> _onSearchUserReset(
      SearchUserReset event, Emitter<SearchUserState> emit) {
    emit(SearchUserInitial());
  }
}
