import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:vania/vania.dart';

class AuthenticateMiddleware extends Authenticate {}

class AuthenticateWebSocketMiddleware extends WebSocketMiddleware {
  @override
  Future handle(HttpRequest req) async {
    String? token =
        req.headers['authorization']?.first.replaceFirst('Bearer ', '');
    try {
      await Auth().check(token ?? '');

      return await next?.handle(req);
    } catch (e) {
      print('authenticate error: $e');
      throw AppResponse()
          .error(statusCode: HttpStatus.unauthorized, message: 'Token expired');
    }
  }
}
