import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order_details.dart';

// import 'package:vania/vania.dart';

class OrderDetailsRepo {
  final OrderDetails orderDetails;

  OrderDetailsRepo(this.orderDetails);

  Future createOrderDetails(Map<String, dynamic> data) async {
    return await orderDetails.query().insert(data);
  }

  Future updateOrderDetails(
      {required int id, required Map<String, dynamic> data}) async {
    return await orderDetails.query().where('id', '=', id).update(data);
  }

  Future deleteOrderDetails({required int id}) async {
    return await orderDetails.query().where('id', '=', id).delete();
  }

  Future findOrderDetails({required int id}) async {
    return await orderDetails.query().where('id', '=', id).first();
  }
}
