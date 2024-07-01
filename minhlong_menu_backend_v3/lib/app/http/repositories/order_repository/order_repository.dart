import 'dart:async';
import '../../../models/order.dart';

class OrderRepository {
  Future getNewOrders() async {
    var orders = await Order()
        .query()
        .where('status', '=', 'new')
        .orderBy('created_at', 'desc')
        .get();
    return orders;
  }

  Future getOrderSuccess() async {
    var orders = await Order()
        .query()
        .where('status', '=', 'completed')
        .orderBy('created_at', 'desc')
        .get();
    return orders;
  }

  // Future getOrdersOnDate(Map<String, dynamic> params) async {
  //   var startDate = params['start_date'];
  //   var endDate = params['end_date'];

  //   var orders = await Order().query().

  // }

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

  Future getAllNewOrders() async {
    return await Order()
        .query()
        .select([
          'order.id',
          'order.status',
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
  }
}
