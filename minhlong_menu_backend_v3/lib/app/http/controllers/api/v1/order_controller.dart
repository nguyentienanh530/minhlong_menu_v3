import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/order_repository/order_repository.dart';
import 'package:minhlong_menu_backend_v3/app/models/order.dart';
import 'package:minhlong_menu_backend_v3/app/models/table.dart';
import 'package:vania/vania.dart';

import '../../../../models/food.dart';
import '../../../../models/order_detail.dart';

class OrderController extends Controller {
  final OrderRepository _orderRepository = OrderRepository();
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create(Request request) async {
    try {
      var tableID = request.input('table_id');
      var listFood = request.input('order_detail') as List;
      var orderID = await Order().query().insertGetId({
        'status': 'new',
        'table_id': tableID,
        'created_at': DateTime.now(),
        'updated_at': DateTime.now(),
      });
      if (orderID != null) {
        var totalPrice = 0.0;
        for (var food in listFood) {
          var foodID = food['food_id'];
          var quantity = food['quantity'];
          var foodDB = await Food().query().where('id', '=', foodID).first();
          var isDiscount = foodDB!['is_discount'];
          var price = foodDB['price'];
          var discount = foodDB['discount'];
          var totalAmount = 0.0;
          if (isDiscount != null && isDiscount == true) {
            double discountAmount = (price * discount.toDouble()) / 100;
            double discountedPrice = price - discountAmount;
            totalAmount = discountedPrice * quantity;
          } else {
            totalAmount = price * quantity;
          }

          await OrderDetail().query().insert({
            'order_id': orderID,
            'food_id': foodID,
            'quantity': quantity,
            'price': price,
            'total_amount': totalAmount,
            'created_at': DateTime.now(),
            'updated_at': DateTime.now()
          });

          await Food()
              .query()
              .where('id', '=', foodID)
              .update({'order_count': foodDB['order_count'] + 1});

          totalPrice = totalPrice + totalAmount;
        }
        await Table().query().where('id', '=', tableID).update({'is_use': 1});

        await Order()
            .query()
            .where('id', '=', orderID)
            .update({'total_price': totalPrice, 'updated_at': DateTime.now()});
      } else {
        return Response.json({'error': 'create order failed'});
      }

      return Response.json({'message': 'create order success'});
    } catch (e) {
      throw Exception('Something went wrong: $e');
    }
  }

  Future<Response> getNewOrdersByTable(Request request) async {
    // request.validate({
    //   'table_id': 'required|integer',
    // });

    try {
      var tableID = request.input('table_id') ?? 0;

      if (tableID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.notFound, message: 'table id not found');
      }

      var orders =
          await _orderRepository.getNewOrdersByTable(int.parse(tableID));

      List<Map<String, dynamic>> formattedOrders = [];

      var groupedOrders = groupOrdersById(orders);

      groupedOrders.forEach((id, ordersList) {
        Map<String, dynamic> orderMap = {
          'id': id,
          'status': ordersList.first['status'],
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
              'photo_gallery': order['photo_gallery'],
            };
          }).toList(),
        };

        formattedOrders.add(orderMap);
      });

      return AppResponse().ok(statusCode: HttpStatus.ok, data: formattedOrders);
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> getNewOrders(Request request) async {
    try {
      int page = request.input('page');
      int limit = request.input('limit');

      var orders = await _orderRepository.getNewOrders();

      final int totalItems = orders.length;
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;
      final int endIndex = startIndex + limit;

      List<Map<String, dynamic>> formattedOrders = [];

      var groupedOrders = groupOrdersById(orders);

      groupedOrders.forEach((id, ordersList) {
        Map<String, dynamic> orderMap = {
          'id': id,
          'status': ordersList.first['status'],
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
              'photo_gallery': order['photo_gallery'],
            };
          }).toList(),
        };

        formattedOrders.add(orderMap);
      });

      List<Map<String, dynamic>> pageData = formattedOrders.sublist(
          startIndex, endIndex < totalItems ? endIndex : totalItems);

      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'page': page,
        'limit': limit,
        'total_page': totalPages,
        'total_item': totalItems,
        'data': pageData
      });
    } catch (e) {
      print('error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Map<int, List<dynamic>> groupOrdersById(List<dynamic> orders) {
    Map<int, List<dynamic>> groupedOrders = {};
    for (var order in orders) {
      if (!groupedOrders.containsKey(order['id'])) {
        groupedOrders[order['id']] = [];
      }
      groupedOrders[order['id']]!.add(order);
    }
    return groupedOrders;
  }

  Future<Response> getOrdersDataChart(Request request) async {
    Map<String, dynamic> data = request.all();
    try {
      // var orders = await _orderRepository.getOrdersDataChart(data);
      var orders = [];
      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        data: orders,
      );
    } catch (e) {
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final OrderController orderController = OrderController();
