import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:vania/vania.dart';

import '../../../../models/user.dart';

class UserController extends Controller {
  Future<Response> index() async {
    try {
      Map? user = Auth().user();

      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }
      user.remove('password');
      return AppResponse().ok(statusCode: HttpStatus.ok, data: user);
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> updateAvatar(Request request) async {
    request.validate({
      'avatar': 'file:jpg,jpeg,png',
    }, {
      'avatar.file': 'The avatar must be an image file.',
    });

    RequestFile? avatar = request.file('avatar');

    String avatarPath = '';

    if (avatar != null) {
      avatarPath = await avatar.move(
          path: 'public/users/${Auth().id()}',
          filename: avatar.getClientOriginalName);
    }

    await User().query().where('id', '=', Auth().id()).update({
      'image': avatarPath,
    });

    return Response.json(
        {'message': 'User avatar updated successfully', 'image': avatarPath});
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
    print(request.all());
    var fullName = request.input('full_name');
    var phoneNumber = request.input('phone_number');

    try {
      var user = Auth().user();
      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }

      await User().query().where('id', '=', user['id']).update({
        'full_name': fullName ?? user['full_name'],
        'phone_number': phoneNumber ?? user['phone_number'],
        'updated_at': DateTime.now(),
      });

      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
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
