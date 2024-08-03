class ApiConfig {
  ApiConfig._();

  static const String host = "http://192.168.1.96:8080";
  static const String baseUrl = "$host/api/v1";

  // static const String  = "http://192.168.1.196:80";
  static const Duration receiveTimeout = Duration(milliseconds: 15000);
  static const Duration connectionTimeout = Duration(milliseconds: 15000);

  //===== User =====
  static const String users = '/manager/users';
  static const String user = '/user';
  static const String updateUser = '/$user/update';
  static const String uploadAvatar = '/$user/upload-avatar';
  static const String changePassword = '/$user/change-password';

  //===== Auth =====
  static const String auth = '/auth';
  static const String login = '/$auth/login';
  static const String forgotPassword = '/$auth/forgot-password';
  static const String refreshToken = '/$auth/refresh-token';
  static const String logout = '/$auth/logout';

  //===== Upload image =====
  static const String uploadImage = '/upload-image';
}
