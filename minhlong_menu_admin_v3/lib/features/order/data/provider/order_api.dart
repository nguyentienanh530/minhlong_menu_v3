import 'package:dio/dio.dart';
import '../../../../core/api_config.dart';
import '../model/order_model.dart';

class OrderApi {
  final Dio dio;

  OrderApi(this.dio);
  Future<OrderModel> getOrders({required int page, required int limit}) async {
    final response = await dio.get(ApiConfig.newOrders,
        queryParameters: {'page': page, 'limit': limit});

    return OrderModel.fromJson(response.data['data']);
  }
}
