import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/repositories/table_repository.dart';

import '../data/model/table_model.dart';

part 'dinner_table_event.dart';
part 'dinner_table_state.dart';

typedef Emit = Emitter<DinnerTableState>;

class DinnerTableBloc extends Bloc<DinnerTableEvent, DinnerTableState> {
  DinnerTableBloc(TableRepository tableRepository)
      : _tableRepository = tableRepository,
        super(DinnerTableInitial()) {
    on<DinnerTableFetched>(_onDinnerTableFetched);
  }

  final TableRepository _tableRepository;

  FutureOr<void> _onDinnerTableFetched(
      DinnerTableFetched event, Emit emit) async {
    emit(DinnerTableInprogress());
    final result = await _tableRepository.getDinnerTables(
        page: event.page, limit: event.limit);
    result.when(
      success: (dinnerTable) {
        if (dinnerTable.tableItems.isEmpty) {
          emit(DinnerTableEmpty());
        } else {
          emit(DinnerTableSuccess(dinnerTable));
        }
      },
      failure: (message) {
        emit(DinnerTableFailure(message));
      },
    );
  }
}
