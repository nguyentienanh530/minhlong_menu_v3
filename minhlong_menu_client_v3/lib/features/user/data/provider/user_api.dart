import 'dart:async';

import 'package:dio/dio.dart';

import '../../../../core/api_config.dart';
import '../model/user_model.dart';

class UserApi {
  final Dio _dio;
  UserApi({required Dio dio}) : _dio = dio;

  Future<UserModel> getUser() async {
    final response = await _dio.get(ApiConfig.user);
    return UserModel.fromJson(response.data['data']);
  }

  Future<bool> updateUser({required UserModel userModel}) async {
    final response =
        await _dio.patch(ApiConfig.updateUser, data: userModel.toJson());
    return response.data['data'];
  }

  Future<bool> updatePassword(
      {required String oldPassword, required String newPassword}) async {
    final response = await _dio.patch(ApiConfig.changePassword,
        queryParameters: {
          'old_password': oldPassword,
          'new_password': newPassword
        });
    return response.data['data'];
  }
}
