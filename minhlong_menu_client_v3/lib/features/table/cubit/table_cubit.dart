import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';

class TableCubit extends Cubit<TableModel> {
  TableCubit() : super(TableModel());

  void changeTable(TableModel table) => emit(table);

  void resetTable() => emit(TableModel());
}
