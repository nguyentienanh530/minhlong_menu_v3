import 'dart:async';
import 'package:dio/dio.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/model/user.dart';
import '../../../../core/api_config.dart';
import '../../../auth/data/model/access_token.dart';
import '../model/user_model.dart';

class UserApi {
  final Dio _dio;
  UserApi({required Dio dio}) : _dio = dio;

  Future<UserModel> getUser({required AccessToken accessToken}) async {
    _dio.options.headers['Authorization'] = 'Bearer ${accessToken.accessToken}';
    _dio.options.headers['Accept'] = 'application/json';
    _dio.options.headers['Content-Type'] = 'application/json';

    final response = await _dio.get(
      ApiConfig.user,
    );
    print('response: $response');
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

  Future<User> getUsers({required int page, required int limit}) async {
    final response = await _dio
        .get(ApiConfig.users, queryParameters: {'page': page, 'limit': limit});
    return User.fromJson(response.data['data']);
  }

  Future<bool> deleteUser({required int id}) async {
    final response = await _dio.delete('${ApiConfig.users}/$id');
    return response.data['data'];
  }

  Future<bool> createUser({required UserModel userModel}) async {
    final response =
        await _dio.post(ApiConfig.createUser, data: userModel.toJson());
    return response.data['data'];
  }

  Future<bool> extenedUser({
    required int userID,
    required String extended,
    required String expired,
  }) async {
    final response = await _dio.patch('${ApiConfig.extenedUser}/$userID',
        queryParameters: {'extended_at': extended, 'expired_at': expired});
    return response.data['data'];
  }

  Future<List<UserModel>> searchUser({required dynamic query}) async {
    final response =
        await _dio.get(ApiConfig.searchUser, queryParameters: {'query': query});
    return (List<UserModel>.from(
      response.data['data'].map((x) => UserModel.fromJson(x)),
    ));
  }
}
