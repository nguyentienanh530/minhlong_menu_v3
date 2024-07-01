import 'package:minhlong_menu_backend_v3/config/auth.dart';
import 'package:vania/vania.dart';
import 'package:minhlong_menu_backend_v3/app/providers/route_service_povider.dart';

// import 'auth.dart';
import 'cors.dart';

Map<String, dynamic> config = {
  'name': env('APP_NAME'),
  'url': env('APP_URL'),
  'timezone': '',
  'cors': cors,
  'auth': authConfig,
  'providers': <ServiceProvider>[
    RouteServiceProvider(),
  ],
};
