import 'package:minhlong_menu_backend_v3/app/http/modules/v1/food/controllers/food_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/home/controller/home_client_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/info/controllers/info_controller.dart';
import 'package:vania/vania.dart';
import '../../app/http/modules/v1/auth/controllers/auth_controller.dart';
import '../../app/http/modules/v1/banner/controllers/banner_controller.dart';
import '../../app/http/modules/v1/category/controllers/category_controller.dart';
import '../../app/http/modules/v1/order/controllers/order_controller.dart';
import '../../app/http/modules/v1/table/controllers/table_controller.dart';
import '../../app/http/controllers/api/v1/upload_image_controller.dart';
import '../../app/http/modules/v1/user/controllers/user_controller.dart';
import '../../app/http/middleware/authenticate.dart';

class Version1 implements Route {
  final BannerController _bannerController;
  final CategoryController _categoryController;
  final OrderController _orderController;
  final FoodController _foodController;
  final InfoController _infoController;
  final TableController _tableController;

  Version1(
      {required BannerController bannerController,
      required CategoryController categoryController,
      required OrderController orderController,
      required FoodController foodController,
      required InfoController infoController,
      required TableController tableController})
      : _bannerController = bannerController,
        _categoryController = categoryController,
        _orderController = orderController,
        _foodController = foodController,
        _infoController = infoController,
        _tableController = tableController;

  @override
  void register() {
    Router.basePrefix('api/v1');

    //======= Auth route =======
    Router.group(() {
      Router.post('login', authController.login);
      Router.post('sign-up', authController.signUp);
      Router.post('refresh-token', authController.refreshToken);
      Router.post('logout', authController.logout);
      Router.post('forgot-password', authController.forgotPassword);
    }, prefix: '/auth');

    //======= User route =======
    Router.group(() {
      Router.get("", userController.index);
      Router.patch("update", userController.update);
      Router.patch("change-password", userController.changePassword);
      Router.delete("/{id}", userController.destroy);
    }, prefix: '/user', middleware: [AuthenticateMiddleware()]);

    //======= Category route =======
    Router.group(
      () {
        Router.get("", _categoryController.index);
        Router.get('quantity', _categoryController.getCategoryQuantity);
        Router.post("", _categoryController.create);
        Router.patch("{id}", _categoryController.update);
        Router.delete("{id}", _categoryController.destroy);
      },
      prefix: '/categories',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Table route =======
    Router.group(
      () {
        Router.get("", _tableController.index);
        Router.post("", _tableController.create);
        Router.patch("{id}", _tableController.update);
        Router.get('quantity', _tableController.getTableQuantity);
        Router.delete("{id}", _tableController.destroy);
      },
      prefix: '/tables',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Food route ======
    Router.group(
      () {
        Router.get("", _foodController.index);
        Router.get("category/{id}", _foodController.getFoodsOnCategory);
        Router.get("quantity", _foodController.getTotalNumberOfFoods);
        Router.delete("{id}", _foodController.destroy);
        Router.post('', _foodController.create);
        Router.patch('{id}', _foodController.update);
        Router.get('search', _foodController.search);
      },
      prefix: '/foods',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Banner route =======
    Router.group(
      () {
        Router.get('', _bannerController.index);
        Router.post('', _bannerController.create);
        Router.patch("{id}", _bannerController.update);
        Router.delete("{id}", _bannerController.destroy);
      },
      prefix: '/banners',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Order route =======
    Router.group(
      () {
        Router.get('new-orders', _orderController.getOrders);
        Router.post('', _orderController.create);
        Router.get('new-orders-by-table', _orderController.getNewOrdersByTable);
        Router.get('orders-chart', _orderController.getOrdersDataChart);
        Router.patch('{id}', _orderController.update);
        Router.delete('{id}', _orderController.destroy);
      },
      prefix: '/orders',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Info route =======
    Router.group(
      () {
        Router.get('', _infoController.index);
        Router.get('best-selling-food', _infoController.bestSellingFood);
        Router.get(
            'revenue-filter-on-date', _infoController.revenueFilterOnDate);
      },
      prefix: '/info',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Upload image =======
    Router.post('/upload-image', uploadImageController.updateImage);
    Router.post("/upload-avatar", uploadImageController.updateAvatar);

    //======= Home =======
    Router.get('client/home', homeClientController.getHomeDataForUser);
  }
}
