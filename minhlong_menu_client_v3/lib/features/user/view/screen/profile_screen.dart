import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_theme.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/theme/cubit/scheme_cubit.dart';
import 'package:minhlong_menu_client_v3/features/theme/data/theme_local_datasource.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/common_back_button.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_string.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../theme/cubit/theme_cubit.dart';
import '../../data/model/user_model.dart';

part '../widget/_profile_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final SharedPreferences sf;
  final _isDarkMode = ValueNotifier(false);
  final _pickColor = ValueNotifier(listScheme.first.color);
  final WidgetStateProperty<Icon?> thumbIcon =
      WidgetStateProperty.resolveWith<Icon?>(
    (Set<WidgetState> states) {
      if (states.contains(WidgetState.selected)) {
        return const Icon(Icons.check);
      }
      return const Icon(Icons.close);
    },
  );
  @override
  void dispose() {
    super.dispose();
    _pickColor.dispose();
    _isDarkMode.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    sf = await SharedPreferences.getInstance();
    _isDarkMode.value = await ThemeLocalDatasource(sf).getDartTheme() ?? false;

    var schemeKey = await ThemeLocalDatasource(sf).getSchemeTheme() ?? '';
    _pickColor.value =
        listScheme.firstWhere((element) => element.key == schemeKey).color;
  }

  @override
  Widget build(BuildContext context) {
    var user = context.watch<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: CommonBackButton(onTap: () => context.pop()),
        automaticallyImplyLeading: false,
        title: Text(
          AppString.profile,
          style: context.titleStyleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: context.sizeDevice.height,
          child: Column(
            children: [
              20.verticalSpace,
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    width: 200,
                    // height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: context.colorScheme.onPrimary, width: 6),
                    ),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: CachedNetworkImage(
                        imageUrl: '${ApiConfig.host}${user.image}',
                        errorWidget: errorBuilderForImage,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Loading(),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        style: context.titleStyleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      10.verticalSpace,
                      Text(
                        '+84 ${user.phoneNumber}',
                        style: context.bodyLarge!.copyWith(
                          color: context.bodyLarge!.color!.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              10.verticalSpace,
              const Divider(
                height: 1,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: defaultPadding),
                width: context.sizeDevice.width,
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.phone),
                        5.horizontalSpace,
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: '0${user.phoneNumber}',
                                  style: context.bodySmall),
                              TextSpan(
                                text: user.phoneNumber != 0
                                    ? ' - 0${user.subPhoneNumber}'
                                    : '',
                                style: context.bodySmall,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      children: [
                        const Icon(Icons.email_rounded),
                        5.horizontalSpace,
                        Text(
                          user.email,
                          style: context.bodySmall,
                        ),
                      ],
                    ),
                    10.verticalSpace,
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Icon(Icons.location_on),
                        5.horizontalSpace,
                        Text(
                          user.address,
                          style: context.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
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
                        AppDialog.showErrorDialog(context, title: msg,
                            onPressedComfirm: () {
                          context.pop();
                          context.read<AuthBloc>().add(AuthLogoutStarted());
                        });
                        break;
                      default:
                        break;
                    }
                  },
                  child: _bodyInfoUser(userModel: user),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
