import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/models/banner.dart';
import 'package:vania/vania.dart';

class BannerController extends Controller {
  Future<Response> index() async {
    try {
      var banner = await Banner().query().select().get();
      print(banner);

      return AppResponse().ok(statusCode: HttpStatus.ok, data: banner);
    } catch (e) {
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

  Future<Response> update(Request request, int id) async {
    return Response.json({});
  }

  Future<Response> destroy(int id) async {
    var banner = await Banner().query().where('id', '=', id).delete();
    return Response.json(banner);
  }
}

final BannerController bannerController = BannerController();
