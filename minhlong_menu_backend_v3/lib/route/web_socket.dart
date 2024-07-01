import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/order_web_socket_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/table_web_socket_controller.dart';
import 'package:vania/vania.dart';
import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/chat_web_socket_controller.dart';

class WebSocketRoute implements Route {
  @override
  void register() {
    Router.websocket('/ws', (WebSocketEvent event) {
      event.on('message', chatController.newMessage);
      event.on('orders', orderWebSocketController.getNewOrders);
      event.on('tables', tableWebSocketController.getTable);
    });
  }
}
