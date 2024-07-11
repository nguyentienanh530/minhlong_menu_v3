import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../../../common/network/dio_exception.dart';
import '../../../../common/network/result.dart';
import '../model/order_item.dart';
import '../model/order_model.dart';
import '../provider/order_api.dart';

class OrderRepository {
  final OrderApi _orderApi;

  OrderRepository({required OrderApi orderApi}) : _orderApi = orderApi;

  Future<Result<OrderModel>> getOrders(
      {required String status, required int page, required int limit}) async {
    try {
      final orderList =
          await _orderApi.getOrders(page: page, limit: limit, status: status);
      return Result.success(orderList);
    } on DioException catch (e) {
      Logger().e('get order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> updateOrder({required OrderItem order}) async {
    try {
      final result = await _orderApi.updateOrder(order: order);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('update order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> delete({required int id}) async {
    try {
      var result = await _orderApi.delete(id: id);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('delete order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
