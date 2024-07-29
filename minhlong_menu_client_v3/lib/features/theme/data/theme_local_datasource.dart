import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/app_string.dart';

class ThemeLocalDatasource {
  ThemeLocalDatasource(this.sf);
  final SharedPreferences sf;

  Future<bool> setTheme(bool? isDark) async {
    return await sf.setBool(AppString.themeKey, isDark!);
  }

  Future<bool?> getTheme() async {
    final bool? theme = sf.getBool(AppString.themeKey);
    if (theme == null) {
      return null;
    }
    return theme;
  }
}
