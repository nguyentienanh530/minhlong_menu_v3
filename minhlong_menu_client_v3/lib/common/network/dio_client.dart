import 'package:dio/dio.dart';
import '../../core/api_config.dart';

//singleton class for DioClient

final dio = Dio(
  BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    // headers: ApiConfig.header,
    connectTimeout: ApiConfig.connectionTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    responseType: ResponseType.json,
  ),
);
