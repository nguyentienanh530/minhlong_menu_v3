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

// ===== Deleted User =====
final class UsersDeleteInProgress extends UsersState {}

final class UsersDeleteSuccess extends UsersState {}

final class UsersDeleteFailure extends UsersState {
  final String errorMessage;
  UsersDeleteFailure(this.errorMessage);
}

// ====== Create User ======
final class UsersCreateInProgress extends UsersState {}

final class UsersCreateSuccess extends UsersState {}

final class UsersCreateFailure extends UsersState {
  final String errorMessage;
  UsersCreateFailure(this.errorMessage);
}

// ====== extended User ======
final class UsersExtendedInProgress extends UsersState {}

final class UsersExtendedSuccess extends UsersState {}

final class UsersExtendedFailure extends UsersState {
  final String errorMessage;
  UsersExtendedFailure(this.errorMessage);
}
