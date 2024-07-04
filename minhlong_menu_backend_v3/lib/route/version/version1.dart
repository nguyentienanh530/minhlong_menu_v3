import 'package:minhlong_menu_backend_v3/app/http/controllers/api/v1/info_controller.dart';
import 'package:vania/vania.dart';
import '../../app/http/controllers/api/v1/auth_controller.dart';
import '../../app/http/controllers/api/v1/banner_controller.dart';
import '../../app/http/controllers/api/v1/category_controller.dart';
import '../../app/http/controllers/api/v1/food_controller.dart';
import '../../app/http/controllers/api/v1/order_controller.dart';
import '../../app/http/controllers/api/v1/table_controller.dart';
import '../../app/http/controllers/api/v1/user_controller.dart';
import '../../app/http/middleware/authenticate.dart';

class Version1 implements Route {
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
      Router.post("/upload-avatar", userController.updateAvatar);
      Router.put("/update", userController.update);
      Router.delete("/{id}", userController.destroy);
    }, prefix: '/user', middleware: [AuthenticateMiddleware()]);

    //======= Category route =======
    Router.group(
      () {
        Router.get("", categoryController.index);
        Router.get('quantity', categoryController.getCategoryQuantity);
        Router.delete("/{id}", categoryController.destroy);
      },
      prefix: '/categories',
    );

    //======= Table route =======
    Router.group(() {
      Router.get("", tableController.index);
      Router.get('quantity', tableController.getTableQuantity);
      Router.delete("/{id}", tableController.destroy);
    }, prefix: '/tables');

    //======= Food route ======
    Router.group(() {
      Router.get("", foodController.getFoods);
      Router.get("new-foods", foodController.getNewFoods);
      Router.get("popular-foods", foodController.getPopularFoods);
      Router.get("category/{id}", foodController.getFoodsOnCategory);
      Router.get("quantity", foodController.getQuantityOfFood);
      Router.delete("/{id}", foodController.destroy);
    }, prefix: '/foods');

    //======= Banner route =======
    Router.group(
      () {
        Router.get('/banners', bannerController.index);
        Router.delete("/{id}", bannerController.destroy);
      },
      // prefix: '/banners',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Order route =======
    Router.group(() {
      Router.post('create-order', orderController.create);
      Router.get('new-orders-by-table', orderController.getNewOrdersByTable);
      Router.get('orders-completed', orderController.getOrderCountSuccess);
      Router.get('orders-chart', orderController.getOrdersDataChart);
    }, prefix: '/orders');

    //======= Info route =======
    Router.get('/info', infoController.index);
  }
}
