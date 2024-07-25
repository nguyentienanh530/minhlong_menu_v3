import 'package:dio/dio.dart';

import 'package:minhlong_menu_client_v3/features/auth/data/model/access_token.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/respositories/auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/data/auth_local_datasource/auth_local_datasource.dart';

//singleton class for DioClient

late Dio dio;

class DioClient {
  final AuthRepository authRepository;
  final SharedPreferences sf;
  final AccessToken currentAccessToken;

  DioClient({
    required this.currentAccessToken,
    required this.authRepository,
    required this.sf,
  });

  InterceptorsWrapper createDioInstance() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        options.headers['Content-Type'] = 'application/json';
        options.headers["Accept"] = "application/json";
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401 &&
            e.response?.data['message'] != 'Invalid token') {
          RequestOptions requestOptions = e.requestOptions;

          var newToken = await getAccessToken(currentAccessToken);
          final newOpts = Options(method: requestOptions.method);
          dio.options.headers["Authorization"] =
              "Bearer ${newToken.accessToken}";
          dio.options.headers['Content-Type'] = 'application/json';
          dio.options.headers["Accept"] = "application/json";
          final response = await dio.request(requestOptions.path,
              options: newOpts,
              cancelToken: requestOptions.cancelToken,
              onReceiveProgress: requestOptions.onReceiveProgress,
              data: requestOptions.data,
              queryParameters: requestOptions.queryParameters);
          handler.resolve(response);
        }
        return handler.next(e);
      },
    );
  }

  Future<AccessToken> getAccessToken(AccessToken token) async {
    // get access token in local
    var currentToken = AccessToken();
    var result = await authRepository.refreshToken(
      refreshToken: token.refreshToken,
    );

    //refresh token handler
    result.when(success: (data) async {
      token = token.copyWith(
        accessToken: data.accessToken,
        refreshToken: data.refreshToken,
      );
      await AuthLocalDatasource(sf).saveAccessToken(token);
    }, failure: (err) async {
      await AuthLocalDatasource(sf).removeAccessToken();
    });
    return currentToken;
  }
}
