import 'package:minhlong_menu_backend_v3/app/http/modules/v1/category/controllers/category_controller.dart';
import 'package:minhlong_menu_backend_v3/app/http/modules/v1/home/controller/home_client_controller.dart';
import 'package:vania/vania.dart';
import '../../app/http/modules/v1/auth/controllers/auth_controller.dart';
import '../../app/http/controllers/api/v1/upload_image_controller.dart';
import '../../app/http/modules/v1/banner/controllers/banner_controller.dart';
import '../../app/http/modules/v1/food/controllers/food_controller.dart';
import '../../app/http/modules/v1/home/controller/home_admin_controller.dart';
import '../../app/http/modules/v1/order/controllers/order_controller.dart';
import '../../app/http/modules/v1/table/controllers/table_controller.dart';
import '../../app/http/modules/v1/user/controllers/user_controller.dart';
import '../../app/http/middleware/authenticate.dart';

class Version1 implements Route {
  @override
  void register() {
    Router.basePrefix('api/v1');

    //======= Auth route =======
    Router.group(() {
      Router.post('login', authCtrl.login);
      Router.post('sign-up', authCtrl.signUp);
      Router.post('refresh-token', authCtrl.refreshToken);
      Router.post('logout', authCtrl.logout);
      Router.post('forgot-password', authCtrl.forgotPassword);
    }, prefix: '/auth');

    //======= User route =======
    Router.group(() {
      Router.get("", userCtrl.index);
      Router.patch("update", userCtrl.update);
      Router.patch("change-password", userCtrl.changePassword);
      Router.delete("/{id}", userCtrl.destroy);
    }, prefix: '/user', middleware: [AuthenticateMiddleware()]);

    //======= Category route =======
    Router.group(
      () {
        Router.get("", categoryCtrl.index);
        // Router.get('quantity', categoryCtrl.getCategoryQuantity);
        Router.post("", categoryCtrl.create);
        Router.patch("{id}", categoryCtrl.update);
        Router.delete("{id}", categoryCtrl.destroy);
      },
      prefix: 'admin/categories',
    );

    //======= Table route =======
    Router.group(() {
      Router.get("", tableCtrl.index);
      Router.get("all", tableCtrl.getAllTables);
      Router.post("", tableCtrl.create);
      Router.patch("{id}", tableCtrl.update);
      Router.get('quantity', tableCtrl.getTableQuantity);
      Router.delete("{id}", tableCtrl.destroy);
    }, prefix: '/admin/tables');

    //======= Food route ======
    Router.group(
      () {
        Router.get("", foodCtrl.index);
        Router.get("quantity", foodCtrl.getTotalNumberOfFoods);
        Router.delete("{id}", foodCtrl.destroy);
        Router.post('', foodCtrl.create);
        Router.patch('{id}', foodCtrl.update);
        Router.get('search', foodCtrl.search);
      },
      prefix: '/admin/foods',
    );

    //======= Banner route =======
    Router.group(
      () {
        Router.get('', bannerCtrl.index);
        Router.post('', bannerCtrl.create);
        Router.patch("{id}", bannerCtrl.update);
        Router.delete("{id}", bannerCtrl.destroy);
      },
      prefix: '/admin/banners',
    );

    //======= Order route =======
    Router.group(
      () {
        Router.get('new-orders', orderCtrl.getOrders);
        Router.post('', orderCtrl.create);
        Router.get('new-orders-by-table', orderCtrl.getNewOrdersByTable);
        Router.get('orders-chart', orderCtrl.getOrdersDataChart);
        Router.patch('status/{id}', orderCtrl.updateStatus);
        Router.patch('{id}', orderCtrl.updateOrder);
        Router.post('payment', orderCtrl.paymentOrder);
        Router.delete('{id}', orderCtrl.destroy);
      },
      prefix: 'admin/orders',
    );

    //======= Home admin =======
    Router.group(
      () {
        Router.get('', homeAdminCtrl.index);
        Router.get('best-selling-food', homeAdminCtrl.bestSellingFood);
        Router.get('revenue-filter-on-date', homeAdminCtrl.revenueFilterOnDate);
      },
      prefix: '/admin/home',
      // middleware: [AuthenticateMiddleware()],
    );

    //======= Upload image =======
    Router.post('/upload-image', uploadImageController.updateImage);
    Router.post("/upload-avatar", uploadImageController.updateAvatar);

    //======= client =======
    Router.group(
      () {
        Router.get('home', homeClientController.getHomeDataForUser);
        Router.get('foods/category/{id}', foodCtrl.getFoodsOnCategory);
        Router.get('foods', foodCtrl.index);
        Router.get("tables/all", tableCtrl.getAllTables);
        Router.post('orders', orderCtrl.create);
      },
      prefix: '/client',
    );
  }
}
