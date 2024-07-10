part of 'dinner_table_bloc.dart';

@immutable
sealed class DinnerTableEvent {}

final class DinnerTableFetched extends DinnerTableEvent {
  final int page;
  final int limit;
  DinnerTableFetched({required this.page, required this.limit});
}

final class DinnerTableDeleted extends DinnerTableEvent {
  final int id;
  DinnerTableDeleted({required this.id});
}
