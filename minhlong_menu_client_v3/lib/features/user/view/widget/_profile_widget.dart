part of '../screen/profile_screen.dart';

extension _ProfileWidget on _ProfileScreenState {
  Widget _bodyInfoUser({required UserModel userModel}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ItemProfile(
              onTap: () => context.push(AppRoute.editProfile, extra: userModel),
              svgPath: AppAsset.user,
              title: AppString.editProfile),
          5.verticalSpace,
          _ItemProfile(
              svgPath: AppAsset.lock,
              title: AppString.changePassword,
              onTap: () => context.push(AppRoute.changePassword)),
          _buildThemeWidget(context),
          5.verticalSpace,
          ListenableBuilder(
            listenable: _pickColor,
            builder: (context, child) {
              return _ItemProfile(
                  svgPath: AppAsset.logout,
                  title: AppString.pickColor,
                  leftIcon: Icon(Icons.color_lens_outlined,
                      color: context.colorScheme.primary),
                  rightIcon: Container(
                    margin: const EdgeInsets.only(right: defaultPadding / 2),
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        color: isDarkMode.value
                            ? _pickColor.value.colorDark
                            : _pickColor.value.colorLight,
                        shape: BoxShape.circle),
                  ),
                  onTap: () async => _showDialogPickThemes());
            },
          ),
          _ItemProfile(
              svgPath: AppAsset.logout,
              title: AppString.logout,
              colorIcon: Colors.red,
              onTap: () => _showDialogLogout()),
        ],
      ),
    );
  }

  void _showDialogPickThemes() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 4,
            actionsAlignment: MainAxisAlignment.center,
            title: Text(
              textAlign: TextAlign.center,
              'Chọn màu chính',
              style: context.titleStyleLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            actions: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                  ),
                  onPressed: () => context.pop(),
                  child: Text(AppString.cancel,
                      style: context.bodyMedium!.copyWith(color: Colors.white)))
            ],
            content: SizedBox(
              width: 300,
              child: GridView.count(
                  crossAxisSpacing: defaultPadding / 2,
                  mainAxisSpacing: defaultPadding / 2,
                  crossAxisCount: 6,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: listScheme.map((e) => _buildItemColor(e)).toList()),
            ),
          );
        }).then(
      (value) {
        if (value is ThemeDTO) {
          _pickColor.value = value;
        }
      },
    );
  }

  Widget _buildItemColor(ThemeDTO e) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      onTap: () async {
        context.pop(e);
        await ThemeLocalDatasource(sf).setSchemeTheme(e.key);
        if (!mounted) return;
        context.read<SchemeCubit>().changeScheme(e.key);
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDarkMode.value ? e.colorDark : e.colorLight,
                border: e.key == context.read<SchemeCubit>().state
                    ? isDarkMode.value
                        ? Border.all(
                            color: context.colorScheme.onSurface, width: 2)
                        : Border.all(
                            color: context.colorScheme.onSurface, width: 2)
                    : Border.all(color: Colors.transparent)),
          ),
          e.key == context.read<SchemeCubit>().state
              ? const Icon(Icons.check, color: Colors.white)
              : const SizedBox()
        ],
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
        return SizedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.all(defaultPadding),
                      child: Icon(
                        Icons.dark_mode_outlined,
                        color: context.colorScheme.primary,
                      )),
                  Text(
                    AppString.darkMode,
                    style: context.bodyMedium!,
                  )
                ],
              ),
              Switch(
                thumbIcon: thumbIcon,
                value: isDarkMode.value,
                onChanged: (value) async {
                  isDarkMode.value = !isDarkMode.value;
                  context.read<ThemeCubit>().changeTheme(value);
                  await ThemeLocalDatasource(sf).setDarkTheme(value);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ItemProfile extends StatelessWidget {
  const _ItemProfile({
    required this.svgPath,
    required this.title,
    required this.onTap,
    // this.titleStyle,
    this.colorIcon,
    this.rightIcon,
    this.leftIcon,
  });

  final Color? colorIcon;
  final String svgPath;
  final Icon? leftIcon;
  final String title;
  // final TextStyle? titleStyle;
  final Widget? rightIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultPadding),
      onTap: onTap,
      child: SizedBox(
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: FittedBox(
            alignment: Alignment.centerLeft,
            fit: BoxFit.scaleDown,
            child: Row(children: [
              Padding(
                  padding: const EdgeInsets.all(defaultPadding),
                  child: leftIcon ??
                      SvgPicture.asset(svgPath,
                          colorFilter: ColorFilter.mode(
                              colorIcon ?? context.colorScheme.primary,
                              BlendMode.srcIn))),
              Text(
                title,
                style: context.bodyMedium!,
              )
            ]),
          ),
        ),
        Expanded(
          child: FittedBox(
            alignment: Alignment.centerRight,
            fit: BoxFit.scaleDown,
            child: rightIcon ??
                const Padding(
                    padding: EdgeInsets.all(defaultPadding),
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 15,
                    )),
          ),
        )
      ])),
    );
  }
}
