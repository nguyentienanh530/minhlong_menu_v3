import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/dto/login_dto.dart';
import '../../../../../core/api_config.dart';
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
    final response = await dio.post(ApiConfig.logout);
    return response.data['data'];
  }
}
