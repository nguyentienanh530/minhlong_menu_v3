import 'dart:async';
import '../../../models/order.dart';

class OrderRepository {
  Future getOrderSuccess() async {
    var orders = await Order()
        .query()
        .where('status', '=', 'completed')
        .orderBy('created_at', 'desc')
        .get();
    return orders;
  }

  Future getNewOrdersByTable(int tableID) async {
    if (tableID == 0) {
      return await Order()
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
            'food.photo_gallery',
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
      return await Order()
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
            'food.photo_gallery',
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
    return await Order()
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
          'food.photo_gallery',
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

  Future update(int id, Map<String, dynamic> orderDataUpdate) async {
    print(orderDataUpdate);
    return await Order().query().where('id', '=', id).update(orderDataUpdate);
  }

  Future find(int id) async {
    return await Order().query().where('id', '=', id).first();
  }

  Future delete(int id) async {
    return await Order().query().where('id', '=', id).delete();
  }
}
