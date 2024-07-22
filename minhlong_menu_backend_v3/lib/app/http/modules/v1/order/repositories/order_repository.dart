import 'dart:async';

import '../models/order.dart';

class OrderRepository {
  final Orders _orders;

  OrderRepository({required Orders orders}) : _orders = orders;
  Future getOrderSuccess() async {
    var orders = await _orders
        .query()
        .where('status', '=', 'completed')
        .orderBy('created_at', 'desc')
        .get();
    return orders;
  }

  Future getOrdersCompleted({
    required int date,
    required int userID,
  }) async {
    return await _orders
        .query()
        .where('status', '=', 'completed')
        .whereDate('payed_at', '=', date)
        .where('user_id', '=', userID)
        .get();
  }

  Future getAllOrdersCompleted({
    required int userID,
  }) async {
    return await _orders
        .query()
        .where('status', '=', 'completed')
        .where('payed_at', '!=', null)
        .where('user_id', '=', userID)
        .get();
  }

  Future getNewOrdersByTable({int? tableID, int? userID}) async {
    if (tableID == 0) {
      return await _orders
          .query()
          .select([
            'orders.id',
            'orders.status',
            'table_id',
            'order_details.quantity',
            'order_details.price',
            'order_details.quantity',
            'order_details.note',
            'order_details.total_amount',
            'foods.name',
            'foods.image1',
            'foods.image2',
            'foods.image3',
            'foods.image4',
            'orders.total_price',
            'orders.payed_at',
            'orders.created_at',
            'orders.updated_at'
          ])
          .join('order_details', 'orders.id', '=', 'order_details.order_id')
          .join('foods', 'foods.id', '=', 'order_details.food_id')
          .where('status', '=', 'new')
          .where('orders.user_id', '=', userID)
          .get();
    } else {
      return await _orders
          .query()
          .select([
            'orders.id',
            'orders.status',
            'table_id',
            'order_details.quantity',
            'order_details.price',
            'order_details.quantity',
            'order_details.note',
            'order_details.total_amount',
            'foods.name',
            'foods.image1',
            'foods.image2',
            'foods.image3',
            'foods.image4',
            'orders.total_price',
            'orders.payed_at',
            'orders.created_at',
            'orders.updated_at'
          ])
          .join('order_details', 'orders.id', '=', 'order_details.order_id')
          .join('foods', 'foods.id', '=', 'order_details.food_id')
          .where('table_id', '=', tableID)
          .where('orders.user_id', '=', userID)
          .where('status', '=', 'new')
          .get();
    }
  }

  Future getOrders(String status) async {
    return await _orders
        .query()
        .select([
          'orders.id',
          'orders.status',
          'orders.table_id',
          'order_details.quantity',
          'order_details.price',
          'order_details.quantity',
          'order_details.note',
          'order_details.total_amount',
          'foods.name',
          'foods.image1',
          'foods.image2',
          'foods.image3',
          'foods.image4',
          'orders.total_price',
          'orders.payed_at',
          'orders.created_at',
          'orders.updated_at'
        ])
        .join('order_details', 'orders.id', '=', 'order_details.order_id')
        .join('foods', 'foods.id', '=', 'order_details.food_id')
        .where('status', '=', status)
        .get();
  }

// get revenua filter on date
  Future getRevenueFiller({
    required int userID,
    required int startDate,
    required int endDate,
  }) async {
    return await _orders
        .query()
        .select([
          'orders.total_price as total_price',
          'orders.payed_at as payed_at',
        ])
        .whereNotNull('payed_at')
        .where('status', 'completed')
        .where('payed_at', '>=', startDate)
        .where('payed_at', '<=', endDate)
        .where('user_id', '=', userID)
        .groupBy('payed_at')
        .get();
  }

  Future updateOrder(int id, Map<String, dynamic> orderDataUpdate) async {
    return await _orders.query().where('id', '=', id).update(orderDataUpdate);
  }

  Future findOrderByID(int id) async {
    return await _orders.query().where('id', '=', id).first();
  }

  Future deleteOrder(int id) async {
    return await _orders.query().where('id', '=', id).delete();
  }

  Future<int> createOrder(Map<String, dynamic> data) async {
    return await _orders.query().insertGetId(data);
  }
}
