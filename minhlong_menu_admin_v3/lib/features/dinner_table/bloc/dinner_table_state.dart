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

final class DinnerTableDeleteInProgress extends DinnerTableState {}

final class DinnerTableDeleteSuccess extends DinnerTableState {}

final class DinnerTableDeleteFailure extends DinnerTableState {
  final String message;
  DinnerTableDeleteFailure(this.message);
}

final class DinnerTableCreateInProgress extends DinnerTableState {}

final class DinnerTableCreateSuccess extends DinnerTableState {
  final int tableID;

  DinnerTableCreateSuccess(this.tableID);
}

final class DinnerTableCreateFailure extends DinnerTableState {
  final String message;
  DinnerTableCreateFailure(this.message);
}

final class DinnerTableUpdateInProgress extends DinnerTableState {}

final class DinnerTableUpdateSuccess extends DinnerTableState {}

final class DinnerTableUpdateFailure extends DinnerTableState {
  final String message;
  DinnerTableUpdateFailure(this.message);
}

final class AllDinnerTablesInProgress extends DinnerTableState {}

final class AllDinnerTablesSuccess extends DinnerTableState {
  final List<TableItem> tables;
  AllDinnerTablesSuccess(this.tables);
}

final class AllDinnerTablesFailure extends DinnerTableState {
  final String message;
  AllDinnerTablesFailure(this.message);
}

final class AllDinnerTablesEmpty extends DinnerTableState {}
