import '../../../../common/network/result.dart';
import '../model/order_model.dart';
import '../provider/order_api.dart';

class OrderRepository {
  final OrderApi _orderApi;

  OrderRepository({required OrderApi orderApi}) : _orderApi = orderApi;

  Future<Result<OrderModel>> getNewOrders(
      {required int page, required int limit}) async {
    try {
      final orderList = await _orderApi.getOrders(page: page, limit: limit);
      return Result.success(orderList);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
