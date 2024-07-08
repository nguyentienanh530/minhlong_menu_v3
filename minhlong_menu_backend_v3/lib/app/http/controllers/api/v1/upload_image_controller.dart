import 'dart:io';

import 'package:vania/vania.dart';

class UploadImageController extends Controller {
  Future<Response> updateImage(Request request) async {
    request.validate({
      'image': 'file:jpg,jpeg,png',
      'path': 'required|string',
    }, {
      'image.file': 'The avatar must be an image file.',
    });

    RequestFile? image = request.file('image');
    String? path = request.input('path');
    try {
      String avatarPath = '';

      if (image != null) {
        avatarPath = await image.move(
            path: 'public/$path', filename: image.getClientOriginalName);
      }

      return Response.json(
          {'message': 'User avatar updated successfully', 'image': avatarPath},
          HttpStatus.ok);
    } catch (e) {
      return Response.json(
          {'message': 'Error'}, HttpStatus.internalServerError);
    }
  }
}

UploadImageController uploadImageController = UploadImageController();
