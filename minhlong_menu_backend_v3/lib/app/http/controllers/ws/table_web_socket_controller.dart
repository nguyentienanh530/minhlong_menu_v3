import 'dart:convert';
import 'package:minhlong_menu_backend_v3/app/models/order.dart';
import 'package:vania/vania.dart';
import '../../repositories/table_repository/table_repository.dart';

class TableWebSocketController extends Controller {
  final TableRepository _tableRepository = TableRepository();
  Future getTable(WebSocketClient client, dynamic data) async {
    print(data);
    if (data == null) {
      return;
    }
    var tableAll = {
      'id': 0,
      'name': 'Tất cả',
      'seats': 0,
      'is_use': false,
    };

    var tables = await _tableRepository.getTables();
    tables = [tableAll, ...tables];
    var newTables = [];
    for (var table in tables) {
      var orderCount = 0;
      if (table['id'] != 0) {
        orderCount = await Order()
            .query()
            .select()
            .where('status', '=', 'new')
            .where('table_id', '=', table['id'])
            .count();
      } else {
        orderCount =
            await Order().query().select().where('status', '=', 'new').count();
      }
      var newTable = {
        'id': table['id'],
        'name': table['name'],
        'seats': table['seats'],
        'is_use': table['is_use'],
        'order_count': orderCount,
      };
      newTables.add(newTable);
    }

    client.emit('tables-ws', jsonEncode(newTables));
    client.broadcast('tables-ws', jsonEncode(newTables));
  }
}

TableWebSocketController tableWebSocketController = TableWebSocketController();
