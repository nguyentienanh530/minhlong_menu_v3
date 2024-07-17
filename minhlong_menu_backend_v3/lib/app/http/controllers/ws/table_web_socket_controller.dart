import 'dart:convert';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order.dart';
import 'package:vania/vania.dart';
import '../../modules/v1/table/repositories/table_repository.dart';

class TableWebSocketController extends Controller {
  final TableRepository _tableRepository;

  TableWebSocketController({required TableRepository tableRepository})
      : _tableRepository = tableRepository;
  Future getTable(WebSocketClient client, dynamic data) async {
    print('data: $data');
    if (data == null) {
      return;
    }
    var tableAll = {
      'id': 0,
      'name': 'Tất cả',
      'seats': 0,
      'is_use': false,
    };
    // var userID = Auth().id();
    // if (userID == null) {
    //   return;
    // }

    var tables = await _tableRepository.getAllTables(userID: data);
    tables = [tableAll, ...tables];
    var newTables = [];
    for (var table in tables) {
      var orderCount = 0;
      if (table['id'] != 0) {
        orderCount = await Orders()
            .query()
            .select()
            .where('status', '=', 'new')
            .where('table_id', '=', table['id'])
            .count();
      } else {
        orderCount =
            await Orders().query().select().where('status', '=', 'new').count();
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
