part of 'user_bloc.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserFecthInProgress extends UserState {}

final class UserFecthSuccess extends UserState {
  final UserModel userModel;
  UserFecthSuccess(this.userModel);
}

final class UserFecthFailure extends UserState {
  final String errorMessage;
  UserFecthFailure(this.errorMessage);
}

final class UserUpdateInProgress extends UserState {}

final class UserUpdateSuccess extends UserState {}

final class UserUpdateFailure extends UserState {
  final String errorMessage;
  UserUpdateFailure(this.errorMessage);
}

final class UserUpdatePasswordInProgress extends UserState {}

final class UserUpdatePasswordSuccess extends UserState {}

final class UserUpdatePasswordFailure extends UserState {
  final String errorMessage;
  UserUpdatePasswordFailure(this.errorMessage);
}
