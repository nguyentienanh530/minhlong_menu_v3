import 'dart:io';

import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/food_repository/food_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/order_repository/order_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/repositories/table_repository/table_repository.dart';
import 'package:vania/vania.dart';

import '../../../repositories/category_repository/category_repository.dart';

class InfoController extends Controller {
  final CategoryRepository _categoryRepository = CategoryRepository();
  final OrderRepository _orderRepository = OrderRepository();
  final FoodRepository _foodRepository = FoodRepository();
  final TableRepository _tableRepository = TableRepository();
  Future<Response> index() async {
    try {
      var categoryCount = await _categoryRepository.getCategoryQuantity();
      var orderCount = await _orderRepository.getOrderSuccess();
      var foodCount = await _foodRepository.getQuantityOfFood();
      var tableCount = await _tableRepository.getTableQuantity();
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
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }
}

final InfoController infoController = InfoController();
