import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:vania/vania.dart';

import '../models/user.dart';

class UserController extends Controller {
  Future<Response> index() async {
    try {
      Map? user = Auth().user();
      print('user: $user');
      print('user: $user');
      user?.remove('password');

      return AppResponse().ok(statusCode: HttpStatus.ok, data: user);
    } catch (e) {
      print('connection error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> create() async {
    return Response.json({});
  }

  Future<Response> store(Request request) async {
    return Response.json({});
  }

  Future<Response> show(int id) async {
    return Response.json({});
  }

  Future<Response> edit(int id) async {
    return Response.json({});
  }

  Future<Response> update(Request request) async {
    request.validate({
      'full_name': 'required|string',
      'phone_number': 'required|numeric',
      'image': 'required|string',
    });

    String? fullName = request.input('full_name');
    int? phoneNumber = request.input('phone_number');
    String? image = request.input('image');

    try {
      var user = Auth().user();
      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }

      await Users().query().where('id', '=', user['id']).update({
        'full_name': fullName ?? user['full_name'],
        'phone_number': phoneNumber ?? user['phone_number'],
        'image': image ?? user['image'],
        'updated_at': DateTime.now(),
      });

      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('update user error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> changePassword(Request request) async {
    String oldPassword = request.input('old_password');
    String newPassword = request.input('new_password');
    try {
      var user = Auth().user();
      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }

      if (!Hash().verify(oldPassword, user['password'])) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'wrong password');
      }

      await Users().query().where('id', '=', user['id']).update({
        'password': Hash().make(newPassword),
      });

      return AppResponse().ok(
          statusCode: HttpStatus.ok, data: true, message: 'Password updated');
    } catch (e) {
      print('update password error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    return Response.json({});
  }
}

final UserController userController = UserController();
