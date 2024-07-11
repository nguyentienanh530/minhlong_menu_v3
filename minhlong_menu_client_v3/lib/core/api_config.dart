class ApiConfig {
  ApiConfig._();

  static const String baseUrl = "http://127.0.0.1:8080/api/v1";
  static const String host = "http://127.0.0.1:8080";
  // static const String  = "http://192.168.1.196:80";
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  //===== Socket =====
  static const String webSocketUrl = 'ws://192.168.1.196:80/ws';

  //===== User =====
  static const String user = '/user';
  static const String updateUser = '/user/update';
  static const String uploadAvatar = '/user/upload-avatar';

  //===== Auth =====
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot-password';
  static const String refreshToken = '/auth/refresh-token';
  static const String logout = '/auth/logout';

  //===== Banner =====
  static const String banners = '/banners';

  //===== Category =====
  static const String categories = '/categories';
  static const String quantityCategories = '/categories/quantity';

  //===== Food =====
  static const String foods = '/foods';
  static const String newFoods = '/foods/new-foods';
  static const String popularFoods = '/foods/popular-foods';
  static const String foodsOnCategory = '/foods/category/';
  static const String quantityOfFoods = '/foods/quantity';

  //===== Table =====
  static const String tables = '/tables';
  static const String quantityTables = '/tables/quantity';

  //===== Order =====
  static const String orders = '/orders';
  static const String newOrdersByTable = '/orders/new-orders-by-table';
  static const String createOrder = '/orders/create-order';
  static const String orderCompleted = '/orders/orders-completed';
  static const String ordersChart = '/orders/orders-chart';
}
