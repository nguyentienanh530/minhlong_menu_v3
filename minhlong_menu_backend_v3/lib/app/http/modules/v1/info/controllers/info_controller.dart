import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/repositories/food_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/repositories/table_repository.dart';
import 'package:vania/vania.dart';

import '../../category/repositories/category_repository.dart';

class InfoController extends Controller {
  final CategoryRepository _categoryRepository;
  final OrderRepository _orderRepository;
  final FoodRepository _foodRepository;
  final TableRepository _tableRepository;

  InfoController(
      {required CategoryRepository categoryRepository,
      required OrderRepository orderRepository,
      required FoodRepository foodRepository,
      required TableRepository tableRepository})
      : _categoryRepository = categoryRepository,
        _orderRepository = orderRepository,
        _foodRepository = foodRepository,
        _tableRepository = tableRepository;
  Future<Response> index() async {
    try {
      final userID = Auth().id();
      if (userID == null) {
        return AppResponse().error(
          statusCode: HttpStatus.unauthorized,
          message: 'unauthorized',
        );
      }
      var categoryCount =
          await _categoryRepository.getCategoryCount(userID: userID);
      var orderCount = await _orderRepository.getOrderSuccess();
      var foodCount =
          await _foodRepository.getTotalNumberOfFoods(userID: userID);
      var tableCount = await _tableRepository.getTableCount(userID: userID);
      return AppResponse().ok(
        statusCode: HttpStatus.ok,
        message: 'success',
        data: {
          'category_count': categoryCount,
          'order_count': orderCount.length,
          'food_count': foodCount,
          'table_count': tableCount
        },
      );
    } catch (e) {
      print('get info error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}
