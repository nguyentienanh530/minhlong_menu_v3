import 'dart:async';

import 'package:minhlong_menu_backend_v3/app/http/modules/v1/user/models/user.dart';

class UserRepo {
  final Users user;

  UserRepo(this.user);

  Future listUser({
    required int startIndex,
    required int limit,
  }) async {
    return await user
        .query()
        .offset(startIndex)
        .limit(limit)
        .where('role', '=', 'user')
        .get();
  }

  Future userCount() async {
    return await user.query().count();
  }

  Future findUser({required int id}) async {
    return await user.query().where('id', '=', id).first();
  }

  Future findUserByPhoneNumber({required int phoneNumber}) async {
    print(phoneNumber.runtimeType);
    return await user.query().where('phone_number', '=', phoneNumber).first();
  }

  Future updateUser(
      {required int userID, required Map<String, dynamic> data}) async {
    return await user.query().where('id', '=', userID).update(data);
  }

  Future deleteUser({required int id}) async {
    return await user.query().where('id', '=', id).delete();
  }

  Future createUser({required Map<String, dynamic> data}) async {
    return await user.query().insert(data);
  }

  Future searchUser({required String query}) async {
    return await user
        .query()
        .where('role', '=', 'user')
        .where('full_name', 'like', '%$query%')
        .orWhere('phone_number', 'like', '%${query.replaceFirst('0', '')}%')
        .where('role', '=', 'user')
        .get();
  }
}
