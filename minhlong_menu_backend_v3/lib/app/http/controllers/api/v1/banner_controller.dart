import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/models/banner.dart';
import 'package:vania/vania.dart';

import '../../../repositories/banner_repository/banner_repository.dart';

class BannerController extends Controller {
  final _bannerRepository = BannerRepository();
  Future<Response> index(Request request) async {
    var params = request.all();
    var type = params['type'] ?? 'all';
    int page = request.input('page') ?? 1;
    int limit = request.input('limit') ?? 10;
    try {
      var totalItems = await _bannerRepository.bannerCount();
      var totalPages = (totalItems / limit).ceil();
      var startIndex = (page - 1) * limit;

      if (type == 'all') {
        var banner = await _bannerRepository.getAll();

        return AppResponse().ok(statusCode: HttpStatus.ok, data: {
          'pagination': {
            'page': page,
            'limit': limit,
            'total_page': totalPages,
            'total_item': totalItems,
          },
          'data': banner,
        });
      } else {
        var banner =
            await _bannerRepository.get(startIndex: startIndex, limit: limit);
        return AppResponse().ok(statusCode: HttpStatus.ok, data: {
          'pagination': {
            'page': page,
            'limit': limit,
            'total_page': totalPages,
            'total_item': totalItems,
          },
          'data': banner,
        });
      }
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
