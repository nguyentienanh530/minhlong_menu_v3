import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_string.dart';
import '../model/access_token.dart';

class AuthLocalDatasource {
  AuthLocalDatasource(this.sf);
  final SharedPreferences sf;

  Future<bool> saveAccessToken(AccessToken accessToken) async {
    return await sf.setString(
        AppString.accessTokenkey, jsonEncode(accessToken));
  }

  Future<AccessToken?> getAccessToken() async {
    final String? accessToken = sf.getString(AppString.accessTokenkey);
    if (accessToken == null) {
      return null;
    }
    return AccessToken.fromJson(jsonDecode(accessToken));
  }

  Future<bool> removeAccessToken() async {
    return await sf.remove(AppString.accessTokenkey);
  }
}
