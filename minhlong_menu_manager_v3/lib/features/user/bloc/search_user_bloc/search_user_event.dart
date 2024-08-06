part of 'search_user_bloc.dart';

@immutable
sealed class SearchUserEvent {}

class SearchUserStarted extends SearchUserEvent {
  final dynamic query;
  SearchUserStarted(this.query);
}

class SearchUserReset extends SearchUserEvent {}
