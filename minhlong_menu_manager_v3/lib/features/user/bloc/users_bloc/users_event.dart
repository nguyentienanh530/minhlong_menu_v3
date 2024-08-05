part of 'users_bloc.dart';

@immutable
sealed class UsersEvent {}

class UsersFetched extends UsersEvent {
  final int page;
  final int limit;
  UsersFetched({required this.page, required this.limit});
}

class UsersDeleted extends UsersEvent {
  final int id;
  UsersDeleted({required this.id});
}

class UsersCreated extends UsersEvent {
  final UserModel userModel;
  UsersCreated({required this.userModel});
}

class UsersExtended extends UsersEvent {
  final int userID;
  final String extended;
  final String expired;
  UsersExtended({
    required this.userID,
    required this.extended,
    required this.expired,
  });
}
