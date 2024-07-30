import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/app_string.dart';

class ThemeLocalDatasource {
  ThemeLocalDatasource(this.sf);
  final SharedPreferences sf;

  Future<bool> setDarkTheme(bool? isDark) async {
    return await sf.setBool(AppString.themeKey, isDark!);
  }

  Future<bool?> getDartTheme() async {
    final bool? theme = sf.getBool(AppString.themeKey);
    if (theme == null) {
      return null;
    }
    return theme;
  }

  Future<bool> setSchemeTheme(String? schemeKeyValue) async {
    return await sf.setString(AppString.schemeKey, schemeKeyValue!);
  }

  Future<String?> getSchemeTheme() async {
    final String? scheme = sf.getString(AppString.schemeKey);
    if (scheme == null) {
      return null;
    }
    return scheme;
  }
}
