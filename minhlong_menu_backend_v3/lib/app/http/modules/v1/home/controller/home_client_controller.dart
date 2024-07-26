import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/modules/v1/banner/models/banners.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/banner/repositories/banner_repo.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/models/categories.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/repositories/food_repo.dart';
import 'package:vania/vania.dart';

import '../../../../common/app_response.dart';
import '../../../../common/const_res.dart';
import '../../category/repositories/category_repo.dart';
import '../../food/models/foods.dart';

class HomeClientController extends Controller {
  final BannerRepo bannerRepo = BannerRepo(Banners());
  final CategoryRepo _categoryRepo = CategoryRepo(Categories());
  final FoodRepo _foodRepo = FoodRepo(Foods());
  Future<Response> getHomeDataForUser(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;

    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      } else {
        var banner = await bannerRepo.getAllForUsers(userID: userID);
        var category = await _categoryRepo.getAllForUsers(userID: userID);
        var newFoods = await _foodRepo.get(
            byProperty: 'created_at', startIndex: 1, limit: 10, userID: userID);
        var popularFoods = await _foodRepo.get(
            byProperty: 'order_count',
            startIndex: 1,
            limit: 10,
            userID: userID);
        return AppResponse().ok(
          data: {
            'banners': banner,
            'categories': category,
            'newFoods': newFoods,
            'popularFoods': popularFoods
          },
          statusCode: HttpStatus.ok,
        );
      }
    } catch (e) {
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}

HomeClientController homeClientController = HomeClientController();
