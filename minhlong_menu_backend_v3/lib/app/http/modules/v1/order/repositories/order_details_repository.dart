import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order_detail.dart';
// import 'package:vania/vania.dart';

class OrderDetailsRepository {
  final OrderDetails _orderDetails;

  OrderDetailsRepository({required OrderDetails orderDetails})
      : _orderDetails = orderDetails;

  //  Future createOrderDetail(Map<String, dynamic> data) async {
  //   return await _orderDetails
  //       .query()
  //       .insertMany(data );
  // }
}
