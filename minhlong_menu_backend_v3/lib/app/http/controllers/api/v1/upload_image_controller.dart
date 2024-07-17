import 'dart:io';

import 'package:vania/vania.dart';

import '../../../modules/v1/user/models/user.dart';

class UploadImageController extends Controller {
  Future<Response> updateImage(Request request) async {
    request.validate({
      'image': 'file:jpg,jpeg,png,webp,avif',
      'path': 'required|string',
    }, {
      'image.file': 'The avatar must be an image file.',
    });
    print(request.all());

    RequestFile? image = request.file('image');

    String? path = request.input('path');
    try {
      String avatarPath = '';

      if (image != null) {
        avatarPath = await image.move(
            path: 'public/$path/${Auth().id()}',
            filename: image.getClientOriginalName);
      }

      return Response.json(
          {'message': 'User avatar updated successfully', 'image': avatarPath},
          HttpStatus.ok);
    } catch (e) {
      print('Error uploading image: $e');
      return Response.json(
          {'message': 'Error'}, HttpStatus.internalServerError);
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

    await Users().query().where('id', '=', Auth().id()).update({
      'image': avatarPath,
    });

    return Response.json(
        {'message': 'User avatar updated successfully', 'image': avatarPath});
  }
}

UploadImageController uploadImageController = UploadImageController();
