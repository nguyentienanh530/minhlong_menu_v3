import 'package:bloc/bloc.dart';

import '../data/model/table_item.dart';

class DinnerTableCubit extends Cubit<List<TableItem>> {
  DinnerTableCubit() : super(<TableItem>[]);
  void setTableList(List<TableItem> list) => emit(list);
}
