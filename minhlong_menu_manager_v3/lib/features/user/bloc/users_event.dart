part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class UsersFetched extends UsersEvent {
  final int page;
  final int limit;
  UsersFetched({required this.page, required this.limit});
}
