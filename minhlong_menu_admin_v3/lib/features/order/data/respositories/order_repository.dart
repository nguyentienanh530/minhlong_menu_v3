import 'package:minhlong_menu_admin_v3/features/order/data/model/order_model.dart';

import '../../../../common/network/result.dart';
import '../provider/order_api.dart';

class OrderRepository {
  final OrderApi _orderApi;

  OrderRepository({required OrderApi orderApi}) : _orderApi = orderApi;

  Future<Result<List<OrderModel>>> getNewOrders() async {
    try {
      final orderList = await _orderApi.getOrders();
      return Result.success(orderList);
    } catch (e) {
      return Result.failure(e.toString());
    }
  }
}
