part of '../screen/profile_screen.dart';

extension _ProfileWidget on _ProfileScreenState {
  Widget _bodyInfoUser({required UserModel userModel}) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(defaultBorderRadius * 2),
          topRight: Radius.circular(defaultBorderRadius * 2),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ItemProfile(
                onTap: () =>
                    context.push(AppRoute.editProfile, extra: userModel),
                svgPath: AppAsset.user,
                title: AppString.editProfile),
            5.verticalSpace,
            _ItemProfile(
                svgPath: AppAsset.lock,
                title: AppString.changePassword,
                onTap: () => context.push(AppRoute.changePassword)),
            _buildThemeWidget(context),
            5.verticalSpace,
            _ItemProfile(
                svgPath: AppAsset.logout,
                title: AppString.logout,
                onTap: () => _showDialogLogout()),
            // _ItemProfile(
            //     svgPath: AppAsset.logout,
            //     title: 'Test ',
            //     onTap: () => AppDialog.showSuccessDialog(
            //           context,
            //           confirmText: 'OK',
            //           title: 'Test',
            //           description: 'Test',
            //           onPressedComfirm: () => context.pop(),
            //         )),
          ],
        ),
      ),
    );
  }

  void _showDialogLogout() {
    AppDialog.showErrorDialog(
      context,
      title: 'Đăng xuất nhó?',
      description: 'Ấy có muốn đăng xuất không?',
      cancelText: 'Thôi',
      haveCancelButton: true,
      confirmText: 'Bái bai',
      onPressedComfirm: () {
        context.read<AuthBloc>().add(AuthLogoutStarted());
      },
    );
    // showDialog(
    //     context: context,
    //     builder: (context) {
    //       return AppDialog(
    //         title: 'Đăng xuất?',
    //         description: 'Bạn có muốn đăng xuất?',
    //         onPressedComfirm: () {
    //           context.read<AuthBloc>().add(AuthLogoutStarted());
    //         },
    //       );
    //     });
  }

  Widget _buildThemeWidget(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, value, child) {
        return Card(
            elevation: 2,
            shadowColor: context.colorScheme.onPrimary,
            child: SizedBox(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: Row(children: [
                        Padding(
                            padding: const EdgeInsets.all(defaultPadding),
                            child: Icon(
                              isDarkMode.value
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              color: context.colorScheme.secondary,
                            )),
                        Text(
                          isDarkMode.value
                              ? AppString.darkMode
                              : AppString.lightMode,
                          style: context.bodyMedium!,
                        )
                      ]),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      alignment: Alignment.centerRight,
                      fit: BoxFit.scaleDown,
                      child: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          activeTrackColor: context.colorScheme.secondary,
                          inactiveTrackColor:
                              context.colorScheme.secondary.withOpacity(0.5),
                          inactiveThumbColor: Colors.white,
                          value: isDarkMode.value,
                          onChanged: (value) async {
                            isDarkMode.value = !isDarkMode.value;
                            context.read<ThemeCubit>().changeTheme(value);
                            await ThemeLocalDatasource(sf).setTheme(value);
                          },
                        ),
                      ),
                    ),
                  ),
                ])));
      },
    );
  }
}

class _ItemProfile extends StatelessWidget {
  const _ItemProfile({
    required this.svgPath,
    required this.title,
    required this.onTap,
    this.titleStyle,
    this.colorIcon,
  });

  final Color? colorIcon;
  final String svgPath;
  final String title;
  final TextStyle? titleStyle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shadowColor: context.colorScheme.onPrimary,
        child: InkWell(
          borderRadius: BorderRadius.circular(defaultPadding),
          onTap: onTap,
          child: SizedBox(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.scaleDown,
                    child: Row(children: [
                      Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: SvgPicture.asset(svgPath,
                              colorFilter: ColorFilter.mode(
                                  context.colorScheme.secondary,
                                  BlendMode.srcIn))),
                      Text(
                        title,
                        style: titleStyle ?? context.bodyMedium!,
                      )
                    ]),
                  ),
                ),
                const Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Padding(
                        padding: EdgeInsets.all(defaultPadding),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                        )),
                  ),
                )
              ])),
        ));
  }
}
