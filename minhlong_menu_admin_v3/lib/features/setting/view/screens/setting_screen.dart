import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_theme.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/user/cubit/user_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_string.dart';
import '../../../theme/cubit/scheme_cubit.dart';
import '../../../theme/cubit/theme_cubit.dart';
import '../../../theme/data/theme_local_datasource.dart';

part '../widgets/_setting_widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late final SharedPreferences sf;
  final _isUsePrinter = ValueNotifier(false);
  final _selectedIndex = ValueNotifier(0);
  final isDarkMode = ValueNotifier(false);
  final _pickColor = ValueNotifier(listScheme.first.colorDark);

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    sf = await SharedPreferences.getInstance();
    isDarkMode.value = await ThemeLocalDatasource(sf).getDartTheme() ?? false;
    var schemeKey = await ThemeLocalDatasource(sf).getSchemeTheme() ?? '';
    _pickColor.value = isDarkMode.value
        ? listScheme.firstWhere((element) => element.key == schemeKey).colorDark
        : listScheme
            .firstWhere((element) => element.key == schemeKey)
            .colorLight;
  }

  @override
  void dispose() {
    super.dispose();
    _isUsePrinter.dispose();
    _selectedIndex.dispose();
    isDarkMode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserCubit>().state;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultBorderRadius).r,
          ),
          child: context.isMobile
              ? Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Column(
                    children: [
                      _buildInfoProfile(user),
                      _editInfoUser(user),
                      _buildTitleChangePassword(),
                      _buildColorThemeWidget(),
                      _buildThemeWidget(context),
                    ],
                  ),
                )
              : Row(
                  children: [
                    const Spacer(),
                    Expanded(
                      flex: 2,
                      child: Container(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Column(
                          children: [
                            _buildInfoProfile(user),
                            _editInfoUser(user),
                            _buildTitleChangePassword(),
                            _buildColorThemeWidget(),
                            _buildThemeWidget(context),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
        ),
      ),
    );
  }
}
