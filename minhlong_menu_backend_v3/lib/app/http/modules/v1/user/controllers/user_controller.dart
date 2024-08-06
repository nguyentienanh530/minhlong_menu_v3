import 'dart:io';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:vania/vania.dart';

import '../../../../common/const_res.dart';
import '../models/user.dart';
import '../repositories/user_repo.dart';

class UserController extends Controller {
  final UserRepo userRepo;

  UserController(this.userRepo);
  Future<Response> index() async {
    try {
      Map? user = Auth().user();
      user?.remove('password');
      return AppResponse().ok(statusCode: HttpStatus.ok, data: user);
    } catch (e) {
      print('connection error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> listUsers(Request request) async {
    var params = request.all();
    int? page = params['page'] != null ? int.tryParse(params['page']) : 1;
    int? limit = params['limit'] != null ? int.tryParse(params['limit']) : 10;
    try {
      var totalItems = await userRepo.userCount();
      var totalPages = (totalItems / limit).ceil();
      var startIndex = (page! - 1) * limit!;

      var users = await userRepo.listUser(limit: limit, startIndex: startIndex);
      print('users: $users');
      return AppResponse().ok(statusCode: HttpStatus.ok, data: {
        'pagination': {
          'page': page,
          'limit': limit,
          'total_page': totalPages,
          'total_item': totalItems
        },
        'data': users
      });
    } catch (e) {
      print('connection error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> update(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    request.validate({
      'full_name': 'required|string',
      'phone_number': 'required|numeric',
      // 'image': 'required|string',
    });

    String? fullName = request.input('full_name');
    int? phoneNumber = request.input('phone_number');
    String? image = request.input('image');
    int? subPhoneNumber = request.input('sub_phone_number');
    String? email = request.input('email');
    String? address = request.input('address');
    String? expiredAt = request.input('expired_at');

    try {
      if (userID == null || userID == -1) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'unauthorized');
      }
      var existUser =
          await userRepo.findUserByPhoneNumber(phoneNumber: phoneNumber!);
      if (existUser != null && existUser['id'] != userID) {
        return AppResponse().error(
            statusCode: HttpStatus.conflict, message: 'phone number exist');
      }
      var user = await userRepo.findUser(id: userID);

      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }

      var userUpdateData = {
        'full_name': fullName ?? user['full_name'],
        'phone_number': phoneNumber,
        'image': image ?? user['image'],
        'sub_phone_number': subPhoneNumber ?? user['sub_phone_number'],
        'email': email ?? user['email'],
        'address': address ?? user['address'],
        'expired_at': expiredAt ?? user['expired_at']
      };
      await userRepo.updateUser(userID: userID, data: userUpdateData);

      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('update user error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> changePassword(Request request) async {
    int? userID = request.headers[ConstRes.userID] != null
        ? int.tryParse(request.headers[ConstRes.userID])
        : -1;
    String oldPassword = request.input('old_password');
    String newPassword = request.input('new_password');
    try {
      var user = await userRepo.findUser(id: userID!);
      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }

      if (!Hash().verify(oldPassword, user['password'])) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'wrong password');
      }

      var userUpdateData = {'password': Hash().make(newPassword)};

      await userRepo.updateUser(userID: userID, data: userUpdateData);

      return AppResponse().ok(
          statusCode: HttpStatus.ok, data: true, message: 'Password updated');
    } catch (e) {
      print('update password error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> destroy(int id) async {
    try {
      var user = await userRepo.findUser(id: id);
      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }

      await userRepo.deleteUser(id: id);
      return AppResponse().ok(data: true, statusCode: HttpStatus.ok);
    } catch (e) {
      print('delete user error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> extendedUser(Request request, int id) async {
    var params = request.all();
    try {
      var user = await userRepo.findUser(id: id);
      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }
      var data = {
        'extended_at': params['extended_at'] ?? user['extended_at'],
        'expired_at': params['expired_at'] ?? user['expired_at'],
      };

      await userRepo.updateUser(userID: id, data: data);
      return AppResponse().ok(statusCode: HttpStatus.ok, data: true);
    } catch (e) {
      print('update password error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  Future<Response> searchUser(Request request) async {
    var params = request.all();
    try {
      dynamic users;

      users = await userRepo.searchUser(query: params['query']);
      print('users: $users');
      return AppResponse().ok(statusCode: HttpStatus.ok, data: users);
    } catch (e) {
      print('search user error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}

final UserController userCtrl = UserController(UserRepo(Users()));
