// import 'dart:io';

// import 'package:dartz/dartz.dart';
// import 'package:dio/dio.dart';
// import 'package:logger/logger.dart';
// import 'package:minhlong_menu_admin_v3/app/core/api_config.dart';
// import 'package:minhlong_menu_admin_v3/app/modules/auth/data/model/user_model.dart';
// import '../../../../../common/network/api_base.dart';
// import '../../../../../common/network/dio_exception.dart';

// class UserApi extends ApiBase<UserModel> {
//   Future<Either<String, UserModel>> getUser() async {
//     try {
//       final Response response = await dioClient.dio!.get(ApiConfig.user);

//       final UserModel userModel = UserModel.fromJson(response.data['data']);
//       return right(userModel);
//     } on DioException catch (e) {
//       var errorMessage = DioExceptions.fromDioError(e).toString();

//       return left(errorMessage);
//     }
//   }

//   Future<Either<String, String>> uploadAvatar(File file) async {
//     var filePath = file.path.split('/').last;

//     FormData formData = FormData.fromMap({
//       "avatar": await MultipartFile.fromFile(file.path, filename: filePath),
//     });

//     try {
//       final response = await dioClient.dio!.post(ApiConfig.uploadAvatar,
//           data: formData, onSendProgress: (count, total) {
//         Logger().w('count: $count, total: $total');
//       });
//       String image = response.data['image'];

//       return right(image);
//     } on DioException catch (e) {
//       final errorMessage = DioExceptions.fromDioError(e).toString();
//       return left(errorMessage);
//     }
//   }

//   Future<Either<String, bool>> updateUser(
//       {required UserModel userModel}) async {
//     return makePutRequest(dioClient.dio!
//         .put(ApiConfig.updateUser, queryParameters: userModel.toJson()));
//   }
// }


