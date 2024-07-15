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

  Future getNewOrdersByTable(int tableID) async {
    if (tableID == 0) {
      return await _orders
          .query()
          .select([
            'order.id',
            'order.status',
            'table_id',
            'order_detail.quantity',
            'order_detail.price',
            'order_detail.quantity',
            'order_detail.note',
            'order_detail.total_amount',
            'food.name',
            'food.image1',
            'food.image2',
            'food.image3',
            'food.image4',
            'order.total_price',
            'order.payed_at',
            'order.created_at',
            'order.updated_at'
          ])
          .join('order_detail', 'order.id', '=', 'order_detail.order_id')
          .join('food', 'food.id', '=', 'order_detail.food_id')
          .where('status', '=', 'new')
          .get();
    } else {
      return await _orders
          .query()
          .select([
            'order.id',
            'order.status',
            'table_id',
            'order_detail.quantity',
            'order_detail.price',
            'order_detail.quantity',
            'order_detail.note',
            'order_detail.total_amount',
            'food.name',
            'food.image1',
            'food.image2',
            'food.image3',
            'food.image4',
            'order.total_price',
            'order.payed_at',
            'order.created_at',
            'order.updated_at'
          ])
          .join('order_detail', 'order.id', '=', 'order_detail.order_id')
          .join('food', 'food.id', '=', 'order_detail.food_id')
          .where('table_id', '=', tableID)
          .where('status', '=', 'new')
          .get();
    }
  }

  Future getOrders(String status) async {
    return await _orders
        .query()
        .select([
          'order.id',
          'order.status',
          'order.table_id',
          'order_detail.quantity',
          'order_detail.price',
          'order_detail.quantity',
          'order_detail.note',
          'order_detail.total_amount',
          'food.name',
          'food.image1',
          'food.image2',
          'food.image3',
          'food.image4',
          'order.total_price',
          'order.payed_at',
          'order.created_at',
          'order.updated_at'
        ])
        .join('order_detail', 'order.id', '=', 'order_detail.order_id')
        .join('food', 'food.id', '=', 'order_detail.food_id')
        .where('status', '=', status)
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
