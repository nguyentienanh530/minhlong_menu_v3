part of 'dinner_table_bloc.dart';

@immutable
sealed class DinnerTableState {}

final class DinnerTableInitial extends DinnerTableState {}

final class DinnerTableInprogress extends DinnerTableState {}

final class DinnerTableEmpty extends DinnerTableState {}

final class DinnerTableSuccess extends DinnerTableState {
  final TableModel tableModel;
  DinnerTableSuccess(this.tableModel);
}

final class DinnerTableFailure extends DinnerTableState {
  final String message;
  DinnerTableFailure(this.message);
}
