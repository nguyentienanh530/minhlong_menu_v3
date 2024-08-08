import 'dart:convert';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order.dart';
import 'package:vania/vania.dart';
import '../../modules/v1/table/repositories/table_repo.dart';

class TableWebSocketController extends Controller {
  final TableRepo tableRepo;

  TableWebSocketController(this.tableRepo);
  Future getTable(WebSocketClient client, dynamic userID) async {
    if (userID == null) {
      return;
    }

    // var tableAll = {
    //   'id': 0,
    //   'name': 'Tất cả',
    //   'seats': 0,
    //   'is_use': false,
    // };

    var tables = await tableRepo.getAllTables(userID: userID);
    // tables = [tableAll, ...tables];
    var newTables = [];
    for (var table in tables) {
      var orderCount = 0;
      if (table['id'] != 0) {
        orderCount = await Orders()
            .query()
            .select()
            .whereRaw('orders.status IN ("new", "processing")')
            .where('table_id', '=', table['id'])
            .count();
      } else {
        orderCount = await Orders()
            .query()
            .select()
            .whereRaw('orders.status IN ("new", "processing")')
            .count();
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

    client.toRoom('tables-ws', 'tables-$userID', jsonEncode(newTables));
  }
}
