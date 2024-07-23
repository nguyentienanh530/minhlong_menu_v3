import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:minhlong_menu_admin_v3/features/auth/data/model/access_token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/api_config.dart';
import 'dio_client.dart';

class DioInterceptor extends Interceptor {
  final SharedPreferences sf;
  late AuthLocalDatasource _authLocalDatasource;

  final Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      printTime: false,
    ),
  );

  DioInterceptor(this.sf) {
    _authLocalDatasource = AuthLocalDatasource(sf);
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    logger.i('====================START====================');
    logger.i('HTTP method => ${options.method} ');
    logger.i('Request => ${options.baseUrl}${options.path}');
    logger.i('Header  => ${options.headers}');
    _addTokenIfNeeded(options, handler);
    // super.onRequest(options, handler);
  }

  void _addTokenIfNeeded(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers.containsKey('Authorization')) {
      return handler.next(options);
    }

    final accessToken = await _authLocalDatasource.getAccessToken();
    log('token: $accessToken');
    if (accessToken != null && accessToken.accessToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${accessToken.accessToken}';
      options.headers['Content-Type'] = 'application/json';
      options.headers['Accept'] = 'application/json';
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    if (err.response?.statusCode == 401 &&
        err.response?.data['message'] == 'Token expired') {
      await _authLocalDatasource.removeAccessToken();
    }

    logger.e(options.method); // Debug log
    logger.e(
        'Error: ${err.response!.statusCode}, Message: ${err.message}'); // Error log
    logger.e('Error message: ${err.response?.data['message']}');

    logger.e(
        'Request => ${options.baseUrl}${options.path}${options.queryParameters}');
    super.onError(err, handler);
  }

  void _refreshTokenAndResolveError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    _debugPrint('### Refreshing token... ###');
    final token = await _authLocalDatasource.getAccessToken();
    // final refreshToken = token?.refreshToken;

    if (token == null ||
        token.accessToken.isEmpty ||
        token.refreshToken.isEmpty) {
      return handler.next(err);
    }

    late final AccessToken? accessToken;

    try {
      accessToken = await refreshTokenFuction(token: token) ?? token;
    } on DioException catch (e) {
      print('caching error $e');

      return handler.next(e);
    }

    _debugPrint('### Token refreshed! ###');

    err.requestOptions.headers['Authorization'] =
        'Bearer ${accessToken.accessToken}';

    final refreshResponse = await Dio().fetch(err.requestOptions);
    return handler.resolve(refreshResponse);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('Response => StatusCode: ${response.statusCode}'); // Debug log
    logger.d('Response => Body: ${response.data}'); // Debug log
    return super.onResponse(response, handler);
  }

  Future<AccessToken?> refreshTokenFuction({required AccessToken token}) async {
    try {
      final response = await dio.post(
        ApiConfig.refreshToken,
        queryParameters: {
          'refresh_token': token.refreshToken,
          // 'access_token': token.accessToken
        },
      );

      if (response.statusCode == HttpStatus.created) {
        final newToken = AccessToken.fromJson(response.data['data']);
        await _authLocalDatasource.saveAccessToken(newToken);
        return newToken;
      }

      return null;
    } catch (e) {
      logger.e('refreshToken went wrong $e');
      return null;
    }
  }

  void _debugPrint(String message) {
    if (kDebugMode) {
      print(message);
    }
  }
}

// class MyHttpInterceptor extends Interceptor {
//   List<Map<dynamic, dynamic>> failedRequests = [];
//   bool isRefreshing = false;
//   final SharedPreferences sf;
//   late AuthLocalDatasource _authLocalDatasource;

//   MyHttpInterceptor(this.sf) {
//     _authLocalDatasource = AuthLocalDatasource(sf);
//   }

//   @override
//   void onRequest(
//       RequestOptions options, RequestInterceptorHandler handler) async {
//     debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
//     final accessToken = await _authLocalDatasource.getAccessToken();
//     log('token: ${accessToken?.accessToken}');
//     if (accessToken != null && accessToken.accessToken.isNotEmpty) {
//       options.headers['Authorization'] = 'Bearer ${accessToken.accessToken}';
//       options.headers['Content-Type'] = 'application/json';
//       options.headers['Accept'] = 'application/json';
//     }
//     handler.next(options);
//   }

//   @override
//   void onResponse(Response response, ResponseInterceptorHandler handler) async {
//     debugPrint(
//         'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

//     handler.next(response);
//   }

//   @override
//   void onError(DioException err, ErrorInterceptorHandler handler) async {
//     debugPrint(
//         'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}, IS REFRESHING: ${isRefreshing.toString()}');
//     if (err.response?.statusCode == 401) {
//       var token = await _authLocalDatasource.getAccessToken();
//       if (token == null || token.refreshToken.isEmpty) {
//         debugPrint("LOGGING OUT: NO REFRESH TOKEN FOUND");
//         // perform logout
//         return handler.reject(err);
//       }

//       if (!isRefreshing) {
//         debugPrint("ACCESS TOKEN EXPIRED, GETTING NEW TOKEN PAIR");
//         isRefreshing = true;
//         await refreshToken(err, handler, token.refreshToken);
//       } else {
//         debugPrint("ADDING ERRRORED REQUEST TO FAILED QUEUE");
//         failedRequests.add({'err': err, 'handler': handler});
//       }
//     } else {
//       return handler.next(err);
//     }
//   }

//   FutureOr refreshToken(DioException err, ErrorInterceptorHandler handler,
//       String refreshToken) async {
//     var retryDio = Dio(
//       BaseOptions(
//         baseUrl: ApiConfig.baseUrl,
//         headers: <String, String>{
//           'Content-Type': 'application/json',
//           'Authorization': 'Bearer $refreshToken}',
//           'Accept': 'application/json'
//         },
//       ),
//     );
//     // handle refresh token
//     var response = await retryDio.post(ApiConfig.refreshToken);
//     var parsedResponse = response.data;
//     if (response.statusCode == 401 || response.statusCode == 403) {
//       // handle logout
//       debugPrint("LOGGING OUT: EXPIRED REFRESH TOKEN");
//       return handler.reject(err);
//     }

//     // handle setting tokens in your store for future requests

//     isRefreshing = false;
//     failedRequests.add({'err': err, 'handler': handler});
//     debugPrint("RETRYING ${failedRequests.length} FAILED REQUEST(s)");
//     retryRequests(parsedResponse['data']['access_token']);
//     return null;
//   }

//   Future retryRequests(token) async {
//     Dio retryDio = Dio(
//       BaseOptions(
//         baseUrl: ApiConfig.baseUrl,
//       ),
//     );

//     for (var i = 0; i < failedRequests.length; i++) {
//       debugPrint(
//           'RETRYING[$i] => PATH: ${failedRequests[i]['err'].requestOptions.path}');
//       RequestOptions requestOptions =
//           failedRequests[i]['err'].requestOptions as RequestOptions;
//       requestOptions.headers = {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json'
//       };
//       await retryDio.fetch(requestOptions).then(
//             failedRequests[i]['handler'].resolve,
//             onError: (error) =>
//                 failedRequests[i]['handler'].reject(error as DioException),
//           );
//     }
//     isRefreshing = false;
//     failedRequests = [];
//   }
// }


