import 'dart:io';
import 'dart:math';
import 'package:minhlong_menu_backend_v3/app/http/common/app_response.dart';
import 'package:vania/vania.dart';
import '../../user/models/user.dart';

class AuthController extends Controller {
  /// Login
  Future<Response> login(Request request) async {
    request
        .validate({'phone_number': 'required|numeric', 'password': 'required'});

    var phoneNumber = request.input('phone_number');

    String password = request.input('password').toString();
    try {
      final user =
          await Users().query().where('phone_number', '=', phoneNumber).first();

      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }

      if (!Hash().verify(password, user['password'])) {
        return AppResponse().error(
            statusCode: HttpStatus.unauthorized, message: 'wrong password');
      }

      // If you have guard and multi access like user and admin you can pass the guard Auth().guard('admin')
      Map<String, dynamic> token = await Auth().login(user).createToken(
            withRefreshToken: true,
            // expiresIn: Duration(days: 365 * 10),
            expiresIn: Duration(minutes: 1),
          ); // 1 minute for testing

      return AppResponse().ok(data: token, statusCode: HttpStatus.ok);
    } catch (e) {
      print('login error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }

  /// Creating new user
  Future<Response> signUp(Request request) async {
    request.validate(
      {
        'phone_number': 'required|numeric',
        'password': 'required',
        'full_name': 'required|string',
      },
      // {
      //   'phone_number.required': 'The phone number is required',
      //   'phone_number.numeric': 'The phone number is not valid',
      //   'password.required': 'The password is required',
      // }
    );

    /// Checking if the user already exists
    try {
      Map<String, dynamic>? user = await Users()
          .query()
          .where('phone_number', '=', request.input('phone_number'))
          .first();
      if (user != null) {
        return AppResponse()
            .error(statusCode: HttpStatus.conflict, message: 'user exists');
      }

      await Users().query().insert({
        'phone_number': request.input('phone_number'),
        'full_name': request.input('full_name'),
        'password': Hash().make(request.input('password').toString()),
        'created_at': DateTime.now(),
        'updated_at': DateTime.now(),
      });

      return Response.json({'message': 'User created successfully'});
    } catch (e) {
      print('create user error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> otp(Request request) {
    Random rnd = Random();
    int otp = rnd.nextInt(999999 - 111111);

    Cache.put('otp', otp.toString(), duration: Duration(minutes: 3));

    return Response.json({'message': 'OTP sent successfully'});
  }

  Future<Response> verifyOTO(Request request) async {
    String otp = request.input('otp');
    final otpValue = await Cache.get('otp');

    if (otpValue == otp) {
      Cache.delete('otp');
      return Response.json({'message': 'OTP verified successfully'});
    } else {
      return Response.json(
        {'message': 'Invalid OTP'},
        400,
      );
    }
  }

  Future<Response> refreshToken(Request request) async {
    try {
      String? refreshToken = request.input('refresh_token');

      // String? refreshToken =
      //     request.header('Authorization')?.replaceFirst('Bearer ', '');

      if (refreshToken == null) {
        return AppResponse().error(
            message: 'Invalid token', statusCode: HttpStatus.unauthorized);
      }

      final token = await Auth().createTokenByRefreshToken(
        refreshToken,
        // expiresIn: Duration(days: 365 * 10),
        expiresIn: Duration(minutes: 1),
      );
      return AppResponse().ok(statusCode: HttpStatus.created, data: token);
    } catch (e) {
      print('refreshToken error: ${e.toString()}');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> logout(Request request) async {
    try {
      var isDeleted = await Auth().deleteCurrentToken();
      return AppResponse().ok(statusCode: HttpStatus.ok, data: isDeleted);
    } catch (e) {
      print('logout error: $e');
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> forgotPassword(Request request) async {
    request
        .validate({'phone_number': 'required|numeric', 'password': 'required'});
    var params = request.all();

    int? phoneNumber = params['phone_number'];

    String? password = params['password'];
    print('phoneNumber: $phoneNumber');
    print('password: $password');
    try {
      final user =
          await Users().query().where('phone_number', '=', phoneNumber).first();
      print('user: $user');
      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }
      if (Hash().verify(password!, user['password'])) {
        return AppResponse().error(
            statusCode: HttpStatus.badRequest,
            message: 'new password same as old password');
      }

      await Users().query().update({
        'password': Hash().make(password.toString()),
      });

      return AppResponse().ok(
          data: true, statusCode: HttpStatus.ok, message: 'Password updated');
    } catch (e) {
      print('forgotPassword error: $e');
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}

final AuthController authController = AuthController();
