part of '../screens/setting_screen.dart';

extension _SettingWidgets on _SettingScreenState {
  Widget _buildInfoProfile(UserModel user) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: 0.25 * context.sizeDevice.height,
          height: 0.25 * context.sizeDevice.height,
          decoration: BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.smokeWhite, width: 6),
          ),
          child: Container(
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: '${ApiConfig.host}${user.image}',
              errorWidget: errorBuilderForImage,
              placeholder: (context, url) => const Loading(),
              fit: BoxFit.cover,
            ),
          ),
        ),
        10.verticalSpace,
        _nameAndPhoneWidgets(user),
      ],
    );
  }

  Widget _nameAndPhoneWidgets(UserModel user) {
    return Column(
      children: [
        Text(
          user.fullName,
          style: kHeadingStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          '+84 ${user.phoneNumber}',
          style: kBodyStyle.copyWith(
              color: AppColors.secondTextColor, fontSize: 12),
        ),
      ],
    );
  }

  Widget _editInfoUser(UserModel user) {
    return _ItemProfile(
      onTap: () => context.push<bool>(AppRoute.editProfile, extra: user),
      colorIcon: context.colorScheme.primary,
      svgPath: AppAsset.user,
      title: AppString.editProfile,
    );
  }

  Widget _buildTitleChangePassword() {
    return _ItemProfile(
      onTap: () => context.push(AppRoute.updatePassword),
      colorIcon: context.colorScheme.primary,
      svgPath: AppAsset.lock,
      title: AppString.changePassword,
    );
  }

  Widget _buildTitleChangePassword2() {
    return _ItemProfile(
      colorIcon: context.colorScheme.primary,
      svgPath: AppAsset.lock,
      title: AppString.changePassword,
      onTap: () => AppDialog.showErrorDialog(
        context,
        title: '132123',
        onPressedComfirm: () => context.pop(),
        cancelText: 'ok',
        confirmText: 'cancel',
        description: 'Do you want to change your password',
        haveCancelButton: true,
      ),
    );
  }

  Widget _buildColorThemeWidget() {
    return ListenableBuilder(
      listenable: _pickColor,
      builder: (context, child) {
        return _ItemProfile(
          svgPath: AppAsset.logout,
          title: AppString.pickColor,
          leftIcon: const Icon(Icons.color_lens_outlined),
          rightIcon: Container(
            margin: const EdgeInsets.only(right: defaultPadding / 2),
            height: 30,
            width: 30,
            decoration:
                BoxDecoration(color: _pickColor.value, shape: BoxShape.circle),
          ),
          onTap: () async => _showDialogPickThemes(),
        );
      },
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
        if (value is Color) {
          _pickColor.value = value;
        }
      },
    );
  }

  Widget _buildItemColor(ThemeDTO e) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      onTap: () async {
        context.pop(e.color);
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
                color: e.color,
                border: e.key == context.read<SchemeCubit>().state
                    ? Border.all(color: context.colorScheme.primary, width: 2)
                    : Border.all(color: Colors.transparent)),
          ),
          e.key == context.read<SchemeCubit>().state
              ? const Icon(Icons.check, color: Colors.white)
              : const SizedBox()
        ],
      ),
    );
  }

  Widget _buildThemeWidget(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isDarkMode,
      builder: (context, value, child) {
        return Card(
            elevation: 2,
            // shadowColor: context.colorScheme.onPrimary,
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
                            padding: const EdgeInsets.all(defaultPadding - 3),
                            child: Icon(
                              Icons.dark_mode_outlined,
                              color: context.colorScheme.primary,
                            )),
                        Text(
                          AppString.darkMode,
                          style: kBodyStyle.copyWith(
                              color: AppColors.secondTextColor),
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
                          activeTrackColor: context.colorScheme.primary,
                          inactiveTrackColor:
                              context.colorScheme.primary.withOpacity(0.5),
                          inactiveThumbColor: Colors.white,
                          value: isDarkMode.value,
                          onChanged: (value) async {
                            isDarkMode.value = !isDarkMode.value;
                            context.read<ThemeCubit>().changeTheme(value);
                            await ThemeLocalDatasource(sf).setDarkTheme(value);
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
    this.rightIcon,
    this.leftIcon,
  });

  final Color? colorIcon;
  final String svgPath;
  final Icon? leftIcon;
  final String title;
  final TextStyle? titleStyle;
  final Widget? rightIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2,
        shadowColor: AppColors.white,
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
                          child: leftIcon ??
                              SvgPicture.asset(svgPath,
                                  colorFilter: ColorFilter.mode(
                                      context.colorScheme.primary,
                                      BlendMode.srcIn))),
                      Text(
                        title,
                        style: titleStyle ?? kBodyStyle,
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
        ));
  }
}
