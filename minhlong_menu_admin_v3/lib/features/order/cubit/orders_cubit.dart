import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:minhlong_menu_admin_v3/common/network/web_socket_manager.dart';
import 'package:minhlong_menu_admin_v3/core/app_key.dart';
import '../data/model/order_item.dart';

// List<TableItem>
// <TableItem>[]
class OrdersCubit extends Cubit<List<OrderItem>> {
  OrdersCubit(this.webSocketManager) : super(<OrderItem>[]);
  final WebSocketManager webSocketManager;

  void init() {
    webSocketManager.getChannel(AppKeys.orders)!.stream.listen((stream) {
      List<OrderItem> orders = <OrderItem>[];

      var res = jsonDecode(stream);

      String event = res['event'].toString();
      if (event.contains('orders-ws')) {
        var data = jsonDecode(res['payload']);

        orders = List<OrderItem>.from(
          data.map(
            (x) => OrderItem.fromJson(x),
          ),
        );
        emit(orders);
      }
    });
  }
}
