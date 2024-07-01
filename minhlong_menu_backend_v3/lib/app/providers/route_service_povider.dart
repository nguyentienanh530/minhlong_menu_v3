import 'package:minhlong_menu_backend_v3/route/version/version1.dart';
import 'package:vania/vania.dart';
// import 'package:minhlong_menu_backend_v3/route/api_route.dart';
import 'package:minhlong_menu_backend_v3/route/web_socket.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    // ApiRoute().register();
    Version1().register();
    WebSocketRoute().register();
  }
}
