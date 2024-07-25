import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/common_back_button.dart';
import '../../../../common/dialog/error_dialog.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_string.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../auth/data/model/access_token.dart';
import '../../bloc/user_bloc.dart';
import '../../data/model/user_model.dart';

part '../widget/_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _isUsePrinter = ValueNotifier(false);

  @override
  void dispose() {
    super.dispose();

    _isUsePrinter.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userState = context.watch<UserBloc>().state;
    return Scaffold(
      appBar: AppBar(
        leading: CommonBackButton(onTap: () => context.pop()),
        automaticallyImplyLeading: false,
        title: Text(
          AppString.profile,
          style: kHeadingStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: userState is UserFecthSuccess
            ? SizedBox(
                height: context.sizeDevice.height,
                child: Column(
                  children: [
                    20.verticalSpace,
                    SizedBox(
                      height: 250,
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(2),
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                  color: AppColors.smokeWhite, width: 6),
                            ),
                            child: Container(
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: CachedNetworkImage(
                                imageUrl:
                                    '${ApiConfig.host}${userState.userModel.image}',
                                errorWidget: errorBuilderForImage,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => const Loading(),
                              ),
                            ),
                          ),
                          Text(
                            userState.userModel.fullName,
                            style: kHeadingStyle.copyWith(
                                fontWeight: FontWeight.bold, fontSize: 20),
                          ),
                          Text(
                            '+84 ${userState.userModel.phoneNumber}',
                            style: kBodyStyle.copyWith(
                                color: AppColors.secondTextColor, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    20.verticalSpace,
                    Expanded(
                      child: BlocListener<AuthBloc, AuthState>(
                        listener: (context, state) {
                          switch (state) {
                            case AuthLogoutSuccess():
                              context.read<AuthBloc>().add(AuthEventStarted());
                              context.go(AppRoute.login);

                              break;
                            case AuthLogoutFailure(message: final msg):
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ErrorDialog(
                                    title: msg,
                                    onRetryText: 'Thử lại',
                                    onRetryPressed: () {
                                      context.pop();
                                      context
                                          .read<AuthBloc>()
                                          .add(AuthLogoutStarted());
                                    },
                                  );
                                },
                              );
                              break;
                            default:
                          }
                        },
                        child: _bodyInfoUser(userModel: userState.userModel),
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
