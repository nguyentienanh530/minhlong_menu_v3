import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/order_web_socket_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/table_web_socket_controller.dart';
import 'package:vania/vania.dart';
import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/chat_web_socket_controller.dart';

// import '../app/http/middleware/authenticate.dart';

class WebSocketRoute implements Route {
  final OrderWebSocketController _orderWebSocketController;
  final TableWebSocketController _tableWebSocketController;

  WebSocketRoute(
      {required OrderWebSocketController orderWebSocketController,
      required TableWebSocketController tableWebSocketController})
      : _orderWebSocketController = orderWebSocketController,
        _tableWebSocketController = tableWebSocketController;
  @override
  void register() {
    Router.websocket('/ws', (WebSocketEvent event) {
      event.on('message', chatController.newMessage);
      // event.on('orders', _orderWebSocketController.getNewOrders);
      // event.on('tables', _tableWebSocketController.getTable);
    });
    Router.websocket(
      '/tables',
      (WebSocketEvent event) {
        event.on('tables', _tableWebSocketController.getTable);
      },
      // middleware: [AuthenticateWebSocketMiddleware()],
    );
    Router.websocket(
      '/orders',
      (WebSocketEvent event) {
        event.on('orders', _orderWebSocketController.getNewOrders);
      },
      //  middleware: [AuthenticateWebSocketMiddleware()]
    );
  }
}
