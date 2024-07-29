import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/order_item.dart';
import '../../../../core/api_config.dart';
import '../model/order_model.dart';

class OrderApi {
  final Dio dio;

  OrderApi(this.dio);
  Future<OrderModel> getOrders(
      {required String status, required int page, required int limit}) async {
    final response = await dio.get(ApiConfig.newOrders,
        queryParameters: {'page': page, 'limit': limit, 'status': status});

    return OrderModel.fromJson(response.data['data']);
  }

  Future<bool> updateOrder({required OrderItem order}) async {
    final response = await dio.patch(
      '${ApiConfig.orders}/${order.id}',
      data: order.toJson(),
    );

    return response.data['data'] ?? false;
  }

  Future<bool> delete({required int id}) async {
    final response = await dio.delete('${ApiConfig.orders}/$id');
    return response.data['data'] ?? false;
  }

  Future<bool> createOrder({required OrderItem order}) async {
    final response = await dio.post(ApiConfig.orders, data: order.toJson());
    return response.data['data'];
  }
}
