import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/order_web_socket_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/table_web_socket_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repo.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/models/table.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/repositories/table_repo.dart';
import 'package:minhlong_menu_backend_v3/route/version/version1.dart';
import 'package:vania/vania.dart';
import 'package:minhlong_menu_backend_v3/route/web_socket.dart';
import '../http/modules/v1/order/controllers/order_controller.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    Version1().register();
    WebSocketRoute(
      orderWebSocketController:
          OrderWebSocketController(OrderRepo(Orders()), orderCtrl),
      tableWebSocketController: TableWebSocketController(TableRepo(Tables())),
    ).register();
  }
}
