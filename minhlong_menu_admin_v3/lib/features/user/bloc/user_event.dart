part of 'user_bloc.dart';

@immutable
sealed class UserEvent {}

final class UserFetched extends UserEvent {}

final class UserUpdated extends UserEvent {
  final UserModel userModel;
  UserUpdated(this.userModel);
}
