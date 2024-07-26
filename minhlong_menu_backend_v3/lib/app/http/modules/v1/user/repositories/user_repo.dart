import 'package:minhlong_menu_backend_v3/app/http/modules/v1/user/models/user.dart';

class UserRepo {
  final Users user;

  UserRepo(this.user);

  Future findUser({required int id}) async {
    return await user.query().where('id', '=', id).first();
  }

  Future updateUser(
      {required int userID, required Map<String, dynamic> data}) async {
    return await user.query().where('id', '=', userID).update(data);
  }
}
