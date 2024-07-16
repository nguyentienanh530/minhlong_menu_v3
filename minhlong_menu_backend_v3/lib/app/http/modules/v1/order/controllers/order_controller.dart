import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order_details.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_details_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/models/table.dart';
import 'package:vania/vania.dart';
import '../../food/models/foods.dart';

class OrderController extends Controller {
  final OrderRepository _orderRepository;
  final OrderDetailsRepository _orderDetailsRepository;

  OrderController(
      {required OrderRepository orderRepository,
      required OrderDetailsRepository orderDetailsRepository})
      : _orderRepository = orderRepository,
        _orderDetailsRepository = orderDetailsRepository;
  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create(Request request) async {
    try {
      var tableID = request.input('table_id');
      var listFood = request.input('order_detail') as List;
      var order = {
        'status': 'new',
        'table_id': tableID,
        'created_at': DateTime.now(),
        'updated_at': DateTime.now(),
      };
      var orderID = await _orderRepository.createOrder(order);
      if (orderID != 0) {
        var totalPrice = 0.0;
        for (var food in listFood) {
          var foodID = food['food_id'];
          var quantity = food['quantity'];
          var foodDB = await Foods().query().where('id', '=', foodID).first();
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

          await OrderDetails().query().insert({
            'order_id': orderID,
            'food_id': foodID,
            'quantity': quantity,
            'price': price,
            'total_amount': totalAmount,
            'created_at': DateTime.now(),
            'updated_at': DateTime.now()
          });

          await Foods()
              .query()
              .where('id', '=', foodID)
              .update({'order_count': foodDB['order_count'] + 1});

          totalPrice = totalPrice + totalAmount;
        }
        await Tables().query().where('id', '=', tableID).update({'is_use': 1});
        await _orderRepository
            .updateOrder(orderID, {'total_price': totalPrice});
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
      print('get new orders by table error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<dynamic> getOrders(Request request) async {
    try {
      String status = request.input('status') ?? 'new';
      int page = request.input('page') ?? 1;
      int limit = request.input('limit') ?? 10;

      var orders = await _orderRepository.getOrders(status);

      List<Map<String, dynamic>> formattedOrders = [];

      var groupedOrders = groupOrdersById(orders);

      groupedOrders.forEach((id, ordersList) {
        Map<String, dynamic> orderMap = {
          'id': id,
          'status': ordersList.first['status'],
          'total_price': ordersList.first['total_price'],
          'payed_at': ordersList.first['payed_at'],
          'table_id': ordersList.first['table_id'],
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

      final int totalItems = formattedOrders.length;
      final int totalPages = (totalItems / limit).ceil();
      final int startIndex = (page - 1) * limit;
      final int endIndex = startIndex + limit;

      List<Map<String, dynamic>> pageData = [];
      if (startIndex < totalItems) {
        pageData = formattedOrders.sublist(
            startIndex, endIndex < totalItems ? endIndex : totalItems);
      }

      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': pageData,
      });
    } catch (e) {
      print('get orders error: $e');
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
    // Map<String, dynamic> data = request.all();
    try {
      // var orders = await _orderRepository.getOrdersDataChart(data);
      var orders = [];
      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        data: orders,
      );
    } catch (e) {
      print('get orders data chart error: $e');
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
    try {
      var order = await _orderRepository.findOrderByID(id);
      if (order == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'order not found',
        );
      }
      var orderUpdate = {
        'status': request.input('status') ?? order['status'],
        'total_price': request.input('total_price') ?? order['total_price'],
        'payed_at': request.input('payed_at') ?? order['payed_at'],
        'table_id': request.input('table_id') ?? order['table_id'],
      };

      // print(orderUpdate);
      await _orderRepository.updateOrder(id, orderUpdate);

      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        message: 'updated successfully',
        data: true,
      );
    } catch (e) {
      print('update order error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> destroy(int id) async {
    try {
      var order = await _orderRepository.findOrderByID(id);
      if (order == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'order not found',
        );
      }
      await _orderRepository.deleteOrder(id);
      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        message: 'deleted successfully',
        data: true,
      );
    } catch (e) {
      print('delete order error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}
