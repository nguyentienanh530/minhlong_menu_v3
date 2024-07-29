import 'dart:convert';
import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/controllers/order_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repo.dart';
import 'package:vania/vania.dart';

class OrderWebSocketController extends Controller {
  final OrderRepo orderRepository;
  final OrderController orderController;

  OrderWebSocketController(this.orderRepository, this.orderController);

  Future getNewOrders(WebSocketClient client, dynamic payload) async {
    var userID = payload['user_id'];
    var tableID = payload['table_id'];

    if (userID == null) return;

    if (tableID == null) return;

    try {
      var payloadData = await await orderRepository.getNewOrdersByTable(
          tableID: tableID, userID: userID);
      List<Map<String, dynamic>> formattedOrders = [];

      var groupedOrders = orderController.groupOrdersById(payloadData);

      groupedOrders.forEach(
        (id, ordersList) {
          Map<String, dynamic> orderMap = {
            'id': id,
            'status': ordersList.first['status'],
            'table_id': ordersList.first['table_id'],
            'total_price': ordersList.first['total_price'],
            'payed_at': ordersList.first['payed_at'],
            'created_at': ordersList.first['created_at'],
            'updated_at': ordersList.first['updated_at'],
            'order_detail': ordersList.map((order) {
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
        },
      );

      client.toRoom('orders-ws', 'orders-$userID', jsonEncode(formattedOrders));
    } catch (e) {
      print('get new orders error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}
