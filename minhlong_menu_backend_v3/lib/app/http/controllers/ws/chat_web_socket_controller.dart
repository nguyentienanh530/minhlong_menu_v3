import 'package:vania/vania.dart';

class ChatWebSocketController extends Controller {
  Future newMessage(WebSocketClient client, dynamic message) async {
    print('message: $message');
    client.toRoom('message', "MyRoom", message);
  }
}

ChatWebSocketController chatController = ChatWebSocketController();
