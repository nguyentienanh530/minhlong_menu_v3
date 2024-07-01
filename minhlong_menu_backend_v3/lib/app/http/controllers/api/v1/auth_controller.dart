import 'dart:io';
import 'dart:math';
import 'package:minhlong_menu_backend_v3/app/http/helper/app_response.dart';
import 'package:vania/vania.dart';
import '../../../../models/user.dart';

class AuthController extends Controller {
  /// Login
  Future<Response> login(Request request) async {
    request
        .validate({'phone_number': 'required|numeric', 'password': 'required'});

    var phoneNumber = request.input('phone_number');

    String password = request.input('password').toString();
    try {
      final user =
          await User().query().where('phone_number', '=', phoneNumber).first();

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
          expiresIn: Duration(days: 1)); // 1 minute for testing

      return AppResponse().ok(data: token, statusCode: HttpStatus.ok);
    } catch (e) {
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
      },
      // {
      //   'phone_number.required': 'The phone number is required',
      //   'phone_number.numeric': 'The phone number is not valid',
      //   'password.required': 'The password is required',
      // }
    );

    /// Checking if the user already exists
    Map<String, dynamic>? user = await User()
        .query()
        .where('phone_number', '=', request.input('phone_number'))
        .first();
    if (user != null) {
      return AppResponse()
          .error(statusCode: HttpStatus.conflict, message: 'user exists');
    }

    await User().query().insert({
      'phone_number': request.input('phone_number'),
      'password': Hash().make(request.input('password').toString()),
      'created_at': DateTime.now(),
      'updated_at': DateTime.now(),
    });

    return Response.json({'message': 'User created successfully'});
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
      var refreshToken = request.input('refresh_token');

      final newToken = Auth().createTokenByRefreshToken(refreshToken,
          expiresIn: Duration(days: 1)); // 1 minute for testing
      return AppResponse().ok(data: newToken, statusCode: HttpStatus.ok);
    } catch (e) {
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
      return AppResponse().error(
        statusCode: HttpStatus.internalServerError,
        message: 'connection error',
      );
    }
  }

  Future<Response> forgotPassword(Request request) async {
    request
        .validate({'phone_number': 'required|numeric', 'password': 'required'});

    String phoneNumber = request.input('phone_number');

    String password = request.input('password').toString();
    try {
      final user =
          await User().query().where('phone_number', '=', phoneNumber).first();

      if (user == null) {
        return AppResponse()
            .error(statusCode: HttpStatus.notFound, message: 'user not found');
      }
      if (Hash().verify(password, user['password'])) {
        return AppResponse().error(
            statusCode: HttpStatus.badRequest,
            message: 'new password same as old password');
      }

      await User().query().update({
        'password': Hash().make(password.toString()),
        'updated_at': DateTime.now()
      });

      return AppResponse().ok(
          data: true, statusCode: HttpStatus.ok, message: 'Password updated');
    } catch (e) {
      return AppResponse().error(
          statusCode: HttpStatus.internalServerError,
          message: 'connection error');
    }
  }
}

final AuthController authController = AuthController();
