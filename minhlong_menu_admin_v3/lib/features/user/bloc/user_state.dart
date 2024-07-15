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
