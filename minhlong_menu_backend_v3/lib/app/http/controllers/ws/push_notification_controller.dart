import 'package:vania/vania.dart';

class PushNotificationController extends Controller {
  Future pushNotification(WebSocketClient client, dynamic payload) async {
    int userID = payload['user_id'] ?? -1;
    var message = payload['message'] ?? '';
    if (userID == -1) return;

    client.toRoom(
        'notification-ws', 'notification-$userID', {'message': message});
  }
}

final pushNotificationController = PushNotificationController();
