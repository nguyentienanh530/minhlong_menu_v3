part of 'table_bloc.dart';

@immutable
sealed class TableState {}

final class TableInitial extends TableState {}

final class TableFetchInProgress extends TableState {}

final class TableFetchSuccess extends TableState {
  final List<TableModel> tables;

  TableFetchSuccess(this.tables);
}

final class TableFetchFailure extends TableState {
  final String message;

  TableFetchFailure(this.message);
}

final class TableFetchEmpty extends TableState {}
