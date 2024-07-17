import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_string.dart';
import '../../../../core/app_style.dart';
import '../../../user/bloc/user_bloc.dart';
import '../../../user/view/widgets/change_password.dart';

part '../widgets/_setting_widgets.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _isUsePrinter = ValueNotifier(false);
  final _selectedIndex = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    _isUsePrinter.dispose();
    _selectedIndex.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (context) {
      final userState = context.watch<UserBloc>().state;
      return userState is UserFecthSuccess
          ? Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(defaultPadding),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(defaultBorderRadius).r,
                  ),
                  child: context.isMobile
                      ? Container(
                          constraints: const BoxConstraints(maxWidth: 600),
                          child: Column(
                            children: [
                              _buildInfoProfile(userState.userModel),
                              _editInfoUser(userState.userModel),
                              _buildTitleChangePassword(),
                              _buildItemPrint(context),
                            ],
                          ),
                        )
                      : Row(
                          children: [
                            const Spacer(),
                            Expanded(
                              flex: 2,
                              child: Container(
                                constraints:
                                    const BoxConstraints(maxWidth: 600),
                                child: Column(
                                  children: [
                                    _buildInfoProfile(userState.userModel),
                                    _editInfoUser(userState.userModel),
                                    _buildTitleChangePassword(),
                                    _buildItemPrint(context),
                                  ],
                                ),
                              ),
                            ),
                            const Spacer(),
                          ],
                        )),
            )
          : const Loading();
    }));
  }
}
