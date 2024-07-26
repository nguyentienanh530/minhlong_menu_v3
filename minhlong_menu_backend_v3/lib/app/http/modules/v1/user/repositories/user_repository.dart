import 'package:minhlong_menu_backend_v3/app/http/modules/v1/user/models/user.dart';

class UserRepository {
  final _user = Users();

  Future findUser({required int id}) async {
    return await _user.query().where('id', '=', id).first();
  }
}
