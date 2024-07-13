import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';
import 'package:minhlong_menu_client_v3/features/table/data/repositories/table_repository.dart';

part 'table_event.dart';
part 'table_state.dart';

class TableBloc extends Bloc<TableEvent, TableState> {
  TableBloc({required TableRepository tableRepository})
      : _tableRepository = tableRepository,
        super(TableInitial()) {
    on<TableFetched>(_onTableFetched);
  }
  final TableRepository _tableRepository;

  FutureOr<void> _onTableFetched(
      TableFetched event, Emitter<TableState> emit) async {
    emit(TableFetchInProgress());
    final result = await _tableRepository.getTableList();
    result.when(
      success: (table) {
        if (table.isEmpty) {
          emit(TableFetchEmpty());
        } else {
          emit(TableFetchSuccess(table));
        }
      },
      failure: (message) {
        emit(TableFetchFailure(message));
      },
    );
  }
}
