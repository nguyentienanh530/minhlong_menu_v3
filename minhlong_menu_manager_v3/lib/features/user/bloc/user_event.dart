part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserFetched extends UserEvent {
  final AccessToken accessToken;
  UserFetched(this.accessToken);
}

final class UserUpdated extends UserEvent {
  final UserModel userModel;
  UserUpdated(this.userModel);
}

final class UserUpdatePasswordStarted extends UserEvent {
  final String oldPassword;
  final String newPassword;
  UserUpdatePasswordStarted(
      {required this.oldPassword, required this.newPassword});
}
