// import 'dart:developer';

// import 'package:dartz/dartz.dart';
// import 'package:get/get.dart';
// import 'package:logger/logger.dart';
// import 'package:minhlong_menu_admin_v3/app/common/controller/base_controller.dart';
// import 'package:minhlong_menu_admin_v3/app/Routes/app_route.dart';
// import 'package:minhlong_menu_admin_v3/app/modules/auth/data/model/access_token.dart';
// import 'package:minhlong_menu_admin_v3/app/modules/auth/data/dto/login_dto.dart';
// import 'package:minhlong_menu_admin_v3/app/modules/auth/data/provider/remote/auth_api.dart';
// import 'package:minhlong_menu_admin_v3/app/modules/auth/view/login_screen.dart';
// import '../../../common/network/web_socket_client.dart';
// import '../../../core/api_config.dart';
// import '../../../core/app_datasource.dart';

// class AuthController extends GetxController
//     with StateMixin<AccessToken>, BaseController {
//   static AuthController get to => Get.find();
//   final AuthApi authApi = AuthApi();
//   final WebSocketClient webSocketClient = Get.find();
//   final AppDatasource appDatasource = Get.find();
//   final islogin = false.obs;
//   @override
//   void onInit() {
//     navigateBasedOnLogin();
//     webSocketClient.connect(ApiConfig.webSocketUrl);
//     webSocketClient.send('tables', 0);
//     webSocketClient.send('orders', 0);
//     super.onInit();
//   }

//   void navigateBasedOnLogin() async {
//     final loggedIn = await _isLoggedIn();
//     islogin.value = loggedIn;
//     // if (loggedIn) {
//     //   Get.offAndToNamed(AppRoute.home);
//     // } else {
//     //   Get.offAndToNamed(AppRoute.login);
//     // }
//   }

//   Future<bool> _isLoggedIn() async {
//     var token = await appDatasource.getAccessToken();
//     log('loggedIn: $token');
//     Logger().e('token: ${token?.accessToken}');
//     Logger().e('token: ${token?.accessToken.isNotEmpty}');
//     return token?.accessToken.isNotEmpty ?? false;
//   }

//   void login(LoginDto login) async {
//     change(null, status: RxStatus.loading());
//     Either<String, AccessToken> failureOrSuccess =
//         await authApi.login(login: login);
//     failureOrSuccess.fold((String failure) {
//       change(null, status: RxStatus.error(failure));
//     }, (AccessToken accessToken) async {
//       if (accessToken.accessToken.isEmpty) {
//         change(null, status: RxStatus.empty());
//       } else {
//         await AppDatasource().saveAccessToken(accessToken);
//         Get.offAndToNamed(AppRoute.home);
//         islogin.value = true;
//         change(accessToken, status: RxStatus.success());
//       }
//     });
//   }

//   void logout() async {
//     await authApi.logout();
//     await AppDatasource().removeAccessToken();
//     Get.offAll(() => LoginScreen());
//   }
// }
