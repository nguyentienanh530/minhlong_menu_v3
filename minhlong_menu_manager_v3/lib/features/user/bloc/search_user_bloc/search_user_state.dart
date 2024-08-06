part of 'search_user_bloc.dart';

@immutable
sealed class SearchUserState {}

final class SearchUserInitial extends SearchUserState {}

final class SearchUserInProgress extends SearchUserState {}

final class SearchUserSuccess extends SearchUserState {
  final List<UserModel> users;
  SearchUserSuccess({required this.users});
}

final class SearchUserFailure extends SearchUserState {
  final String message;
  SearchUserFailure({required this.message});
}

final class SearchUserEmpty extends SearchUserState {}
