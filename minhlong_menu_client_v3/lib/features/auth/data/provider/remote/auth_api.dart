import 'dart:io';
import 'package:dio/dio.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/dto/login_dto.dart';
import '../../../../../core/api_config.dart';
// import '../../../../../core/app_datasource.dart';
import '../../model/access_token.dart';

class AuthApi {
  AuthApi({required this.dio});

  final Dio dio;

  Future<AccessToken> login(LoginDto login) async {
    final response = await dio.post(
      ApiConfig.login,
      data: login.toJson(),
    );

    return AccessToken.fromJson(response.data['data']);
  }

  Future<bool> logout() async {
    var isLogOut = false;
    try {
      final response = await dio.post(ApiConfig.logout);
      if (response.statusCode == HttpStatus.ok) {
        isLogOut = true;
      }
      return isLogOut;
    } catch (e) {
      return isLogOut;
    }
  }

  Future<AccessToken> refreshToken({required String refreshToken}) async {
    final response = await dio
        .post(ApiConfig.refreshToken, data: {'refresh_token': refreshToken});
    return AccessToken.fromJson(response.data['data']);
  }

  Future<bool> forgotPassword({required LoginDto login}) async {
    final response =
        await dio.post(ApiConfig.forgotPassword, data: login.toJson());
    return response.data['data'];
  }
}
