import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/banner/models/banners.dart';
import 'package:vania/vania.dart';
import '../../../../common/const_res.dart';
import '../repositories/banner_repo.dart';

class BannerController extends Controller {
  final BannerRepo bannerRepo;

  BannerController(this.bannerRepo);

  Future<Response> index(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    var params = request.all();

    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      int? page = params['page'] != null ? int.tryParse(params['page']) : 1;
      int? limit = params['limit'] != null ? int.tryParse(params['limit']) : 10;
      var totalItems = await bannerRepo.bannerCount(userID: userID);

      dynamic banner;

      int totalPages = (totalItems / limit).ceil();
      int startIndex = (page! - 1) * limit!;
      banner = await bannerRepo.get(
          startIndex: startIndex, limit: limit, userID: userID);

      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems,
        },
        'data': banner,
      });
    } catch (e) {
      print('get banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> create(Request request) async {
    Map<String, dynamic> data = request.all();
    try {
      int? userID = request.headers[ConstRes.userID] != null
          ? int.tryParse(request.headers[ConstRes.userID])
          : -1;

      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var banner = {
        'user_id': userID,
        'image': data['image'] ?? '',
        'show': data['show'] == null ? 0 : (data['show'] ? 1 : 0),
      };
      var bannerID = await bannerRepo.create(data: banner);
      return AppResponse().ok(data: bannerID, statusCode: HttpStatus.ok);
    } catch (e) {
      print('create banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    try {
      await bannerRepo.delete(id: id);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('delete banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> update(Request request, int id) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    Map<String, dynamic> data = request.all();
    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var banner = await bannerRepo.find(id: id);
      if (banner == null) {
        return AppResponse().error(statusCode: HttpStatus.notFound);
      }
      var bannerUpdate = {
        'image': data['image'] ?? '',
        'show': data['show'] == null ? 0 : (data['show'] ? 1 : 0),
      };
      await bannerRepo.update(id: id, data: bannerUpdate);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('update banner error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}

BannerController bannerCtrl = BannerController(BannerRepo(Banners()));
