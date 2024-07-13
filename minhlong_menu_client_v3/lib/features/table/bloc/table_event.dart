part of 'table_bloc.dart';

@immutable
sealed class TableEvent {}

final class TableFetched extends TableEvent {}
