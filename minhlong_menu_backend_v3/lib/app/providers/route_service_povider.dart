import 'package:minhlong_menu_backend_v3/app/http/controllers/ws/order_web_socket_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/banner/controllers/banner_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/banner/models/banners.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/banner/repositories/banner_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/controllers/category_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/models/category.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/repositories/category_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/controllers/food_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/models/food.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/repositories/food_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/info/controllers/info_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/models/order_detail.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_details_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/order/repositories/order_repository.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/controllers/table_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/models/table.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/table/repositories/table_repository.dart';
import 'package:minhlong_menu_backend_v3/route/version/version1.dart';
import 'package:vania/vania.dart';
// import 'package:minhlong_menu_backend_v3/route/api_route.dart';
import 'package:minhlong_menu_backend_v3/route/web_socket.dart';

import '../http/modules/v1/order/controllers/order_controller.dart';

class RouteServiceProvider extends ServiceProvider {
  @override
  Future<void> boot() async {}

  @override
  Future<void> register() async {
    // ApiRoute().register();
    Version1(
        bannerController: BannerController(
          bannerRepository: BannerRepository(
            banner: Banner(),
          ),
        ),
        categoryController: CategoryController(
          categoryRepository: CategoryRepository(
            category: Category(),
          ),
        ),
        foodController: FoodController(
          foodRepository: FoodRepository(
            food: Food(),
          ),
        ),
        orderController: OrderController(
          orderRepository: OrderRepository(
            orders: Orders(),
          ),
          orderDetailsRepository: OrderDetailsRepository(
            orderDetails: OrderDetails(),
          ),
        ),
        tableController: TableController(
          tableRepository: TableRepository(
            tables: Tables(),
          ),
        ),
        infoController: InfoController(
          categoryRepository: CategoryRepository(
            category: Category(),
          ),
          orderRepository: OrderRepository(
            orders: Orders(),
          ),
          foodRepository: FoodRepository(
            food: Food(),
          ),
          tableRepository: TableRepository(
            tables: Tables(),
          ),
        )).register();
    // WebSocketRoute(
    //         orderWebSocketController: OrderWebSocketController(
    //             orderRepository: OrderRepository(orders: Orders()),
    //             orderController: OrderController(
    //                 orderRepository: orderRepository,
    //                 orderDetailsRepository: orderDetailsRepository)))
    //     .register();
  }
}
