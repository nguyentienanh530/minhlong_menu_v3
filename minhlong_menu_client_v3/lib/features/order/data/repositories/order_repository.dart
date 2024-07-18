import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../provider/order_api.dart';

class OrderRepository {
  final OrderApi _orderApi;
  OrderRepository({required OrderApi orderApi}) : _orderApi = orderApi;
  Future<Result<bool>> createOrder({required OrderModel order}) async {
    try {
      var result = await _orderApi.createOrder(orderModel: order);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('create order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
