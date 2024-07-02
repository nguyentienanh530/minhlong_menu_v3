import 'package:bloc/bloc.dart';

import '../data/model/table_model.dart';

class DinnerTableCubit extends Cubit<List<TableModel>> {
  DinnerTableCubit() : super(<TableModel>[]);
  void setTableList(List<TableModel> list) => emit(list);
}
