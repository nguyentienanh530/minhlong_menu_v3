import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/app_string.dart';

class UserLocalDatasource {
  UserLocalDatasource(this.sf);
  final SharedPreferences sf;

  Future<bool> saveUserID(int userID) async {
    return await sf.setString(AppString.userIDKey, userID.toString());
  }

  Future<String?> getUserID() async {
    final String? userID = sf.getString(AppString.userIDKey);
    if (userID == null) {
      return null;
    }
    return userID;
  }

  Future<bool> removeUserID() async {
    return await sf.remove(AppString.userIDKey);
  }
}
