import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/repositories/table_repository.dart';
import '../data/model/table_model.dart';
part 'dinner_table_event.dart';
part 'dinner_table_state.dart';

typedef Emit = Emitter<DinnerTableState>;

class DinnerTableBloc extends Bloc<DinnerTableEvent, DinnerTableState> {
  DinnerTableBloc(DinnerTableRepository tableRepository)
      : _tableRepository = tableRepository,
        super(DinnerTableInitial()) {
    on<DinnerTableFetched>(_onDinnerTableFetched);
    on<DinnerTableDeleted>(_onDinnerTableDeleted);
    on<DinnerTableCreated>(_onDinnerTableCreated);
    on<DinnerTableUpdated>(_onDinnerTableUpdated);
    on<AllDinnerTableFetched>(_onAllDinnerTableFetched);
  }

  final DinnerTableRepository _tableRepository;

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

  FutureOr<void> _onDinnerTableDeleted(
      DinnerTableDeleted event, Emit emit) async {
    emit(DinnerTableDeleteInProgress());
    final result = await _tableRepository.deleteTable(id: event.id);
    result.when(
      success: (success) {
        emit(DinnerTableDeleteSuccess());
      },
      failure: (message) {
        emit(DinnerTableDeleteFailure(message));
      },
    );
  }

  FutureOr<void> _onDinnerTableCreated(
      DinnerTableCreated event, Emit emit) async {
    emit(DinnerTableCreateInProgress());
    final result = await _tableRepository.createTable(table: event.tableItem);
    result.when(
      success: (success) {
        emit(DinnerTableCreateSuccess(success));
      },
      failure: (message) {
        emit(DinnerTableCreateFailure(message));
      },
    );
  }

  FutureOr<void> _onDinnerTableUpdated(
      DinnerTableUpdated event, Emit emit) async {
    emit(DinnerTableUpdateInProgress());
    final result = await _tableRepository.updateTable(table: event.tableItem);
    result.when(
      success: (success) {
        emit(DinnerTableUpdateSuccess());
      },
      failure: (message) {
        emit(DinnerTableUpdateFailure(message));
      },
    );
  }

  FutureOr<void> _onAllDinnerTableFetched(
      AllDinnerTableFetched event, Emit emit) async {
    emit(AllDinnerTablesInProgress());
    final result = await _tableRepository.getAllTables();
    result.when(
      success: (tables) {
        if (tables.isEmpty) {
          emit(AllDinnerTablesEmpty());
        } else {
          emit(AllDinnerTablesSuccess(tables));
        }
      },
      failure: (message) {
        emit(AllDinnerTablesFailure(message));
      },
    );
  }
}
