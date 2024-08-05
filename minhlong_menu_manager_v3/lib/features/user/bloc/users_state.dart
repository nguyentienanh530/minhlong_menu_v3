part of 'users_bloc.dart';

@immutable
sealed class UsersState {}

final class UsersInitial extends UsersState {}

final class UsersFetchInProgress extends UsersState {}

final class UsersFetchSuccess extends UsersState {
  final User users;
  UsersFetchSuccess(this.users);
}

final class UsersFetchFailure extends UsersState {
  final String errorMessage;
  UsersFetchFailure(this.errorMessage);
}

final class UsersFetchEmpty extends UsersState {}
