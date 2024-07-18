import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/order_model.dart';

class OrderApi {
  final Dio _dio;
  OrderApi(Dio dio) : _dio = dio;

  Future<bool> createOrder({required OrderModel orderModel}) async {
    final response =
        await _dio.post(ApiConfig.orders, data: orderModel.toJson());
    return response.data['data'];
  }
}
