import 'dart:async';

import '../models/order.dart';

class OrderRepo {
  final Orders orders;

  OrderRepo(this.orders);
  Future getOrderSuccess() async {
    return await orders
        .query()
        .where('status', '=', 'completed')
        .orderBy('created_at', 'desc')
        .get();
  }

  Future getOrdersCompleted({
    required int date,
    required int userID,
  }) async {
    return await orders
        .query()
        .where('status', '=', 'completed')
        .whereDate('payed_at', '=', date)
        .where('user_id', '=', userID)
        .get();
  }

  Future getAllOrdersCompleted({
    required int userID,
  }) async {
    return await orders
        .query()
        .where('status', '=', 'completed')
        .where('payed_at', '!=', null)
        .where('user_id', '=', userID)
        .get();
  }

  Future getNewOrdersByTable({int? tableID, int? userID}) async {
    print('tableID: $tableID');
    if (tableID == 0) {
      return await orders
          .query()
          .select([
            'orders.id',
            'orders.status',
            'table_id',
            'order_details.id as order_details_id',
            'order_details.quantity',
            'order_details.price',
            'order_details.quantity',
            'order_details.note',
            'order_details.total_amount',
            'foods.id as food_id',
            'foods.name',
            'foods.image1',
            'foods.image2',
            'foods.image3',
            'foods.image4',
            'foods.is_discount',
            'foods.discount',
            'orders.total_price',
            'orders.payed_at',
            'orders.created_at',
            'orders.updated_at'
          ])
          .join('order_details', 'orders.id', '=', 'order_details.order_id')
          .join('foods', 'foods.id', '=', 'order_details.food_id')
          .whereRaw('orders.status IN ("new", "processing")')
          .where('orders.user_id', '=', userID)
          .get();
    } else {
      return await orders
          .query()
          .select([
            'orders.id',
            'orders.status',
            'table_id',
            'order_details.id as order_details_id',
            'order_details.quantity',
            'order_details.price',
            'order_details.quantity',
            'order_details.note',
            'order_details.total_amount',
            'foods.id as food_id',
            'foods.name',
            'foods.image1',
            'foods.image2',
            'foods.image3',
            'foods.image4',
            'foods.is_discount',
            'foods.discount',
            'orders.total_price',
            'orders.payed_at',
            'orders.created_at',
            'orders.updated_at'
          ])
          .join('order_details', 'orders.id', '=', 'order_details.order_id')
          .join('foods', 'foods.id', '=', 'order_details.food_id')
          .where('table_id', '=', tableID)
          .where('orders.user_id', '=', userID)
          .whereRaw('orders.status IN ("new", "processing")')
          .get();
    }
  }

  Future getOrders(String status, int userID, {int? date}) async {
    var select = [
      'orders.id',
      'orders.status',
      'table_id',
      'tables.name as table_name',
      'order_details.id as order_details_id',
      'order_details.quantity',
      'order_details.price',
      'order_details.quantity',
      'order_details.note',
      'order_details.total_amount',
      'foods.id as food_id',
      'foods.name',
      'foods.image1',
      'foods.image2',
      'foods.image3',
      'foods.image4',
      'foods.is_discount',
      'foods.discount',
      'orders.total_price',
      'orders.payed_at',
      'orders.created_at',
      'orders.updated_at'
    ];

    return date == null
        ? await orders
            .query()
            .select(select)
            .join('order_details', 'orders.id', '=', 'order_details.order_id')
            .join('foods', 'foods.id', '=', 'order_details.food_id')
            .join('tables', 'tables.id', '=', 'orders.table_id')
            .where('status', '=', status)
            .where('orders.user_id', '=', userID)
            .get()
        : await orders
            .query()
            .select(select)
            .join('order_details', 'orders.id', '=', 'order_details.order_id')
            .join('foods', 'foods.id', '=', 'order_details.food_id')
            .join('tables', 'tables.id', '=', 'orders.table_id')
            .where('status', '=', status)
            .where('orders.user_id', '=', userID)
            .whereDate('orders.payed_at', '=', date)
            .get();
  }

// get revenua filter on date
  Future getRevenueFiller({
    required int userID,
    required int startDate,
    required int endDate,
  }) async {
    return await orders
        .query()
        .select([
          'orders.total_price as total_price',
          'orders.payed_at as payed_at',
        ])
        .whereNotNull('payed_at')
        .where('status', 'completed')
        .whereDate('payed_at', '>=', startDate)
        .whereDate('payed_at', '<=', endDate)
        .where('user_id', '=', userID)
        .get();
  }

  Future updateOrder(int id, Map<String, dynamic> orderDataUpdate) async {
    return await orders.query().where('id', '=', id).update(orderDataUpdate);
  }

  Future findOrderByID(int id) async {
    return await orders.query().where('id', '=', id).first();
  }

  Future deleteOrder(int id) async {
    return await orders.query().where('id', '=', id).delete();
  }

  Future<int> createOrder(Map<String, dynamic> data) async {
    return await orders.query().insertGetId(data);
  }
}
