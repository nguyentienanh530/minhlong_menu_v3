import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/order_model.dart';

class OrderApi {
  final Dio dio;

  OrderApi(this.dio);
  Future<List<OrderModel>> getOrders() async {
    final response = await dio.get(ApiConfig.newOrders);
    final List<OrderModel> dataList = List<OrderModel>.from(
      json.decode(json.encode(response.data['data'])).map(
            (item) => OrderModel.fromJson(item),
          ),
    );
    return dataList;
  }
}
