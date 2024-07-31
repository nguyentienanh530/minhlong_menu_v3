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
      {required String status,
      required int page,
      required int limit,
      String? date}) async {
    try {
      final orderList = await _orderApi.getOrders(
          page: page, limit: limit, status: status, date: date);
      return Result.success(orderList);
    } on DioException catch (e) {
      Logger().e('get order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> updateStatus(
      {required int orderID, required String status}) async {
    try {
      final result =
          await _orderApi.updateStatus(orderID: orderID, status: status);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('update order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> updateOrder({required OrderItem order}) async {
    try {
      var result = await _orderApi.updateOrder(order: order);
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

  Future<Result<bool>> createOrder({required OrderItem order}) async {
    try {
      var result = await _orderApi.createOrder(order: order);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('create order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }

  Future<Result<bool>> payOrder({required OrderItem order}) async {
    try {
      var result = await _orderApi.payOrder(order: order);
      return Result.success(result);
    } on DioException catch (e) {
      Logger().e('pay order error: $e');
      var errorMessage = DioExceptions.fromDioError(e).toString();
      return Result.failure(errorMessage);
    }
  }
}
