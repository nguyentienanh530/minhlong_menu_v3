import 'dart:convert';
import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/controllers/order_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repo.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/repositories/table_repo.dart';
import 'package:vania/vania.dart';

class OrderWebSocketController extends Controller {
  final OrderRepo orderRepository;
  final OrderController orderController;
  final TableRepo tableRepo;

  OrderWebSocketController(
      this.orderRepository, this.orderController, this.tableRepo);

  Future getNewOrders(WebSocketClient client, dynamic payload) async {
    int userID = payload['user_id'] ?? -1;
    var tableID = payload['table_id'] ?? -1;
    print('userID: $userID, tableID: $tableID');
    if (userID == -1) return;

    if (tableID == -1) return;

    try {
      dynamic payloadData;
      dynamic tableData;

      if (tableID != -1 && tableID != 0) {
        tableData = await tableRepo.find(id: tableID);
        payloadData = await orderRepository.getNewOrdersByTable(
            tableID: tableID, userID: userID);
      } else {
        var tables = await tableRepo.getAllTables(userID: userID);
        tableData = tables.first;
        payloadData = await orderRepository.getNewOrdersByTable(
            tableID: tableData['id'], userID: userID);
      }

      List<Map<String, dynamic>> formattedOrders = [];

      var groupedOrders = orderController.groupOrdersById(payloadData);

      groupedOrders.forEach(
        (id, ordersList) async {
          Map<String, dynamic> orderMap = {
            'id': id,
            'status': ordersList.first['status'],
            'table_id': ordersList.first['table_id'],
            'table_name': tableData['name'] ?? '',
            'total_price': ordersList.first['total_price'],
            'payed_at': ordersList.first['payed_at'],
            'created_at': ordersList.first['created_at'],
            'updated_at': ordersList.first['updated_at'],
            'order_detail': ordersList.map((order) {
              return {
                'order_details_id': order['order_details_id'],
                'food_id': order['food_id'],
                'name': order['name'],
                'quantity': order['quantity'],
                'price': order['price'],
                'note': order['note'],
                'total_amount': order['total_amount'],
                'image1': order['image1'],
                'image2': order['image2'],
                'image3': order['image3'],
                'image4': order['image4'],
                'is_discount': order['is_discount'],
                'discount': order['discount'],
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
