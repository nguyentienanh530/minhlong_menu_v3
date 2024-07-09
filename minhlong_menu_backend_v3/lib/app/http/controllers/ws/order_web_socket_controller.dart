import 'dart:convert';
import 'package:minhlong_menu_backend_v3/app/http/controllers/api/v1/order_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/order_repository/order_repository.dart';
import 'package:vania/vania.dart';

class OrderWebSocketController extends Controller {
  Future getNewOrders(WebSocketClient client, dynamic payload) async {
    if (payload == null) {
      return;
    }

    var payloadData =
        await await OrderRepository().getNewOrdersByTable(payload);
    List<Map<String, dynamic>> formattedOrders = [];

    var groupedOrders = orderController.groupOrdersById(payloadData);

    groupedOrders.forEach((id, ordersList) {
      Map<String, dynamic> orderMap = {
        'id': id,
        'status': ordersList.first['status'],
        'table_id': ordersList.first['table_id'],
        'total_price': ordersList.first['total_price'],
        'payed_at': ordersList.first['payed_at'],
        'created_at': ordersList.first['created_at'],
        'updated_at': ordersList.first['updated_at'],
        'foods': ordersList.map((order) {
          return {
            'name': order['name'],
            'quantity': order['quantity'],
            'price': order['price'],
            'note': order['note'],
            'total_amount': order['total_amount'],
            'image1': order['image1'],
            'image2': order['image2'],
            'image3': order['image3'],
            'image4': order['image4'],
          };
        }).toList(),
      };

      formattedOrders.add(orderMap);
    });

    client.emit('orders-ws', jsonEncode(formattedOrders));
    client.broadcast('orders-ws', jsonEncode(formattedOrders));
  }
}

OrderWebSocketController orderWebSocketController = OrderWebSocketController();
