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
