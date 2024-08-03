part of 'user_bloc.dart';

@immutable
sealed class UserState {
  final UserModel user;

  const UserState(this.user);
}

final class UserInitial extends UserState {
  UserInitial() : super(UserModel());
}

final class UserFecthInProgress extends UserState {
  UserFecthInProgress() : super(UserModel());
}

final class UserFecthSuccess extends UserState {
  const UserFecthSuccess(super.user);
}

final class UserFecthFailure extends UserState {
  final String errorMessage;
  UserFecthFailure(this.errorMessage) : super(UserModel());
}

final class UserUpdateInProgress extends UserState {
  UserUpdateInProgress() : super(UserModel());
}

final class UserUpdateSuccess extends UserState {
  UserUpdateSuccess() : super(UserModel());
}

final class UserUpdateFailure extends UserState {
  final String errorMessage;
  UserUpdateFailure(this.errorMessage) : super(UserModel());
}

final class UserUpdatePasswordInProgress extends UserState {
  UserUpdatePasswordInProgress() : super(UserModel());
}

final class UserUpdatePasswordSuccess extends UserState {
  UserUpdatePasswordSuccess() : super(UserModel());
}

final class UserUpdatePasswordFailure extends UserState {
  final String errorMessage;
  UserUpdatePasswordFailure(this.errorMessage) : super(UserModel());
}
