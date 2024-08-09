import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_admin_v3/common/network/web_socket_manager.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import '../../dinner_table/data/model/table_item.dart';

// List<TableItem>
// <TableItem>[]
class TablesCubit extends Cubit<List<TableItem>> {
  TablesCubit(this.webSocketManager) : super(<TableItem>[]);
  final WebSocketManager webSocketManager;

  void init() {
    webSocketManager.getChannel(AppKeys.tables)!.stream.listen((stream) {
      var res = jsonDecode(stream);
      List<TableItem> dinnerTable = <TableItem>[];
      String event = res['event'].toString();
      if (event.contains('tables-ws')) {
        var data = jsonDecode(res['payload']);

        dinnerTable =
            List<TableItem>.from(data.map((x) => TableItem.fromJson(x)));
      }
      emit(dinnerTable);
    });
  }
}
