import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/repositories/food_repo.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order_details.dart';

import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repo.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/models/table.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/repositories/table_repo.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';
import '../../food/models/foods.dart';
import '../models/order.dart';
import '../repositories/order_details_repo.dart';

class OrderController extends Controller {
  final OrderRepo orderRepo;
  final OrderDetailsRepo orderDetailsRepo;
  final FoodRepo foodRepo;
  final TableRepo tableRepo;

  OrderController(
    this.orderRepo,
    this.orderDetailsRepo,
    this.foodRepo,
    this.tableRepo,
  );

  Future<Response> index() async {
    return Response.json({'message': 'Hello World'});
  }

  Future<Response> create(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    print('userID: $userID');
    print('request: ${request.all()}');
    try {
      var tableID = request.input('table_id');
      var totalPrice = request.input('total_price');
      var listFood = request.input('order_detail') as List;

      if (userID == null || userID == -1) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }
      var order = {
        'status': 'new',
        'table_id': tableID,
        'user_id': userID,
        'total_price': totalPrice
      };
      var orderID = await orderRepo.createOrder(order);
      print('orderID: $orderID');

      if (orderID != 0) {
        for (var food in listFood) {
          var foodID = food['id'];
          var quantity = food['quantity'];
          var foodDB = await foodRepo.find(id: foodID);
          // var isDiscount = foodDB!['is_discount'];
          var price = foodDB!['price'];
          // var discount = foodDB['discount'];
          var totalAmount = food['total_amount'];
          // if (isDiscount != null && isDiscount == true) {
          //   double discountAmount = (price * discount.toDouble()) / 100;
          //   double discountedPrice = price - discountAmount;
          //   totalAmount = discountedPrice * quantity;
          // } else {
          //   totalAmount = price * quantity;
          // }

          var orderDetailsData = {
            'order_id': orderID,
            'food_id': foodID,
            'quantity': quantity,
            'price': price,
            'total_amount': totalAmount,
            'note': food['note']
          };

          await orderDetailsRepo.createOrderDetails(orderDetailsData);

          await foodRepo.update(
              id: foodID, data: {'order_count': foodDB['order_count'] + 1});

          totalPrice = totalPrice + totalAmount;
        }

        await tableRepo.update(id: tableID, tableDataUpdate: {'is_use': 1});
        // await orderRepo.updateOrder(orderID, {'total_price': totalPrice});
      } else {
        return AppResponse().error(
          statusCode: HttpStatus.badRequest,
          message: 'create order failed',
        );
      }

      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('create order error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> getNewOrdersByTable(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    // request.validate({
    //   'table_id': 'required|integer',
    // });

    try {
      var tableID = request.input('table_id') ?? 0;

      if (tableID == null) {
        return AppResponse().error(
            statusCode: HttpStatus.notFound, message: 'table id not found');
      }

      if (userID == null || userID == -1) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }

      var orders = await orderRepo.getNewOrdersByTable(
          tableID: int.parse(tableID), userID: userID);

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
          'order_detail': ordersList.map((order) {
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
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    try {
      String status = request.input('status') ?? 'new';
      int page = request.input('page') ?? 1;
      int limit = request.input('limit') ?? 10;

      if (userID == null || userID == -1) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }

      var orders = await orderRepo.getOrders(status, userID);

      List<Map<String, dynamic>> formattedOrders = [];

      var groupedOrders = groupOrdersById(orders);

      groupedOrders.forEach((id, ordersList) {
        Map<String, dynamic> orderMap = {
          'id': id,
          'status': ordersList.first['status'],
          'total_price': ordersList.first['total_price'],
          'table_name': ordersList.first['table_name'],
          'payed_at': ordersList.first['payed_at'],
          'table_id': ordersList.first['table_id'],
          'created_at': ordersList.first['created_at'],
          'updated_at': ordersList.first['updated_at'],
          'order_detail': ordersList.map((order) {
            return {
              'id': order['food_id'],
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

  Future<Response> update(Request request, int id) async {
    try {
      var order = await orderRepo.findOrderByID(id);
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
      await orderRepo.updateOrder(id, orderUpdate);

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
      var order = await orderRepo.findOrderByID(id);
      if (order == null) {
        return AppResponse().error(
          statusCode: HttpStatus.notFound,
          message: 'order not found',
        );
      }
      await orderRepo.deleteOrder(id);
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

final OrderController orderCtrl = OrderController(
  OrderRepo(Orders()),
  OrderDetailsRepo(OrderDetails()),
  FoodRepo(Foods()),
  TableRepo(Tables()),
);
