import 'package:minhlong_menu_backend_v3/app/http/modules/v1/user/models/user.dart';

Map<String, dynamic> authConfig = {
  'guards': {
    'default': {
      'provider': Users(),
    }
  }
};
