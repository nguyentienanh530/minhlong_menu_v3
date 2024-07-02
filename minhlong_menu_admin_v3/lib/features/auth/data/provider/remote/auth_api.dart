// import 'dart:io';
// import 'package:dio/dio.dart';
// import '../../../../../common/network/api_base.dart';
// import '../../../../../common/network/dio_exception.dart';
// import '../../../view/login_screen.dart';
// import '../../dto/login_dto.dart';
// import '../../model/access_token.dart';

// class AuthApi extends ApiBase<AccessToken> {
//   // Future<Either<String, AccessToken>> login({required LoginDto login}) async {
//   //   try {
//   //     final response = await dioClient.dio!.post(
//   //       ApiConfig.login,
//   //       data: login.toJson(),
//   //     );

//   //     final AccessToken accessToken =
//   //         AccessToken.fromJson(response.data['data']);

//   //     return right(accessToken);
//   //   } on DioException catch (e) {
//   //     final errorMessage = DioExceptions.fromDioError(e).toString();
//   //     return left(errorMessage);
//   //   }
//   }

//   Future<bool> logout() async {
//     var isLogOut = false;
//     try {
//       final response = await dioClient.dio!.post(ApiConfig.logout);
//       if (response.statusCode == HttpStatus.ok) {
//         isLogOut = true;
//       }
//       return isLogOut;
//     } catch (e) {
//       return isLogOut;
//     }
//   }

//   Future<AccessToken?> refreshToken({required String refreshToken}) async {
//     try {
//       AccessToken accessToken = AccessToken(accessToken: '', refreshToken: '');
//       final response = await dioClient.dio!
//           .post(ApiConfig.refreshToken, data: {'refresh_token': refreshToken});

//       if (response.statusCode == HttpStatus.ok) {
//         final token = AccessToken.fromJson(response.data['data']);
//         accessToken = accessToken.copyWith(
//             accessToken: token.accessToken, refreshToken: token.refreshToken);
//         await AppDatasource().saveAccessToken(accessToken);
//       }

//       return accessToken;
//     } catch (e) {
//       await AppDatasource().removeAccessToken();
//       Get.offAll(() => LoginScreen());
//       throw 'Something went wrong $e';
//     }
//   }
// }

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/dto/login_dto.dart';
import '../../../../../core/api_config.dart';
import '../../../../../core/app_datasource.dart';
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

  Future<AccessToken?> refreshToken({required String refreshToken}) async {
    try {
      AccessToken accessToken = AccessToken(accessToken: '', refreshToken: '');
      final response = await dio
          .post(ApiConfig.refreshToken, data: {'refresh_token': refreshToken});

      if (response.statusCode == HttpStatus.ok) {
        final token = AccessToken.fromJson(response.data['data']);
        accessToken = accessToken.copyWith(
            accessToken: token.accessToken, refreshToken: token.refreshToken);
        await AppDatasource().saveAccessToken(accessToken);
      }

      return accessToken;
    } catch (e) {
      await AppDatasource().removeAccessToken();
      // Get.offAll(() => LoginScreen());
      throw 'refreshToken went wrong $e';
    }
  }
}
