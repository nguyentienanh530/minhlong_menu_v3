import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order_details.dart';

// import 'package:vania/vania.dart';

class OrderDetailsRepo {
  final OrderDetails orderDetails;

  OrderDetailsRepo(this.orderDetails);

  Future createOrderDetails(Map<String, dynamic> data) async {
    return await orderDetails.query().insert(data);
  }
}
