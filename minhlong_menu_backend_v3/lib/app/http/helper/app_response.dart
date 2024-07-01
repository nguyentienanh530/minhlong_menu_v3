import 'dart:async';
import 'package:vania/vania.dart';

class AppResponse {
  AppResponse({
    this.status,
    this.message,
    this.data,
  });

  String? status;
  String? message;
  Object? data;

  Map<String, dynamic> toJsonOk() => {
        'status': 'success',
        'message': message,
        'data': data,
      };

  Map<String, dynamic> toJsonErr() => {'status': 'error', 'message': message};

  Future<Response> ok(
      {required int statusCode, Object? data, String? message}) {
    final completer = Completer<Response>();
    final response = Response.json(
        AppResponse(
          message: message ?? 'success',
          data: data,
        ).toJsonOk(),
        statusCode);

    completer.complete(response);
    return completer.future;
  }

  Future<Response> error({required int? statusCode, String? message}) {
    final completer = Completer<Response>();
    final response = Response.json(
      AppResponse(message: message ?? '').toJsonErr(),
      statusCode!,
    );
    completer.complete(response);
    return completer.future;
  }
}
