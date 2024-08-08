part of '../screens/setting_screen.dart';

extension _SettingWidgets on _SettingScreenState {
  Widget _buildInfoProfile(UserModel user) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: context.sizeDevice.height * 0.4,
            child: Row(
              children: [
                Expanded(
                  child: CachedNetworkImage(
                    imageUrl: '${ApiConfig.host}${user.image}',
                    errorWidget: errorBuilderForImage,
                    placeholder: (context, url) => const Loading(),
                    fit: BoxFit.cover,
                    imageBuilder: (context, imageProvider) => Container(
                      height: context.sizeDevice.height * 0.4,
                      width: context.sizeDevice.height * 0.4,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          defaultPadding.verticalSpace,
          const Divider(),
          defaultPadding.verticalSpace,
          _buildExpiryWidget(user),
          defaultPadding.verticalSpace,
          _userNameWidget(user),
          defaultPadding.verticalSpace,
          _buildPhoneWidget(user),
          defaultPadding.verticalSpace,
          _buildEmailWidget(user),
          defaultPadding.verticalSpace,
          _buildAddressWidget(user),
          defaultPadding.verticalSpace,
          _buildExtendedDateWidget(user),
          defaultPadding.verticalSpace,
          _buildExpiryDateWidget(user),
          defaultPadding.verticalSpace,
        ],
      ),
    );
  }

  Widget _userNameWidget(UserModel user) {
    return Text(
      user.fullName,
      style: context.titleStyleLarge!.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _editInfoUser(UserModel user) {
    return _ItemProfile(
      onTap: () => context.push<bool>(AppRoute.editProfile, extra: user),
      colorIcon: context.colorScheme.primary,
      svgPath: AppAsset.user,
      title: AppString.editProfile,
      titleStyle: context.bodyMedium!
          .copyWith(color: context.bodyMedium!.color!.withOpacity(0.7)),
    );
  }

  Widget _buildTitleChangePassword() {
    return _ItemProfile(
      onTap: () => context.push(AppRoute.updatePassword),
      colorIcon: context.colorScheme.primary,
      svgPath: AppAsset.lock,
      title: AppString.changePassword,
      titleStyle: context.bodyMedium!
          .copyWith(color: context.bodyMedium!.color!.withOpacity(0.7)),
    );
  }

  Widget _buildColorThemeWidget() {
    return ListenableBuilder(
      listenable: _pickColor,
      builder: (context, child) {
        return _ItemProfile(
          svgPath: AppAsset.logout,
          title: AppString.pickColor,
          titleStyle: context.bodyMedium!.copyWith(
            color: context.bodyMedium!.color!.withOpacity(0.7),
          ),
          leftIcon: Icon(Icons.color_lens_outlined,
              color: context.colorScheme.primary),
          rightIcon: ListenableBuilder(
              listenable: isDarkMode,
              builder: (context, _) {
                return Container(
                  margin: const EdgeInsets.only(right: defaultPadding / 2),
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      color: isDarkMode.value
                          ? _pickColor.value.colorDark
                          : _pickColor.value.colorLight,
                      shape: BoxShape.circle),
                );
              }),
          onTap: null,
        );
      },
    );
  }

  Widget _buildItemColor(ThemeDTO e) {
    return InkWell(
      borderRadius: BorderRadius.circular(defaultBorderRadius),
      onTap: () async {
        // context.pop();
        _pickColor.value = e;
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
                      : Border.all(color: Colors.transparent))),
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
        return InkWell(
          borderRadius: BorderRadius.circular(defaultPadding),
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
                        style: context.bodyMedium!.copyWith(
                          color: context.bodyMedium!.color!.withOpacity(0.7),
                        ),
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
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPhoneWidget(UserModel user) {
    return _buildItemInfoUserWidget(
        icon: Icons.phone,
        value: '0${user.phoneNumber} - 0${user.subPhoneNumber}');
  }

  _buildEmailWidget(UserModel user) {
    return _buildItemInfoUserWidget(icon: Icons.email, value: user.email);
  }

  _buildAddressWidget(UserModel user) {
    return _buildItemInfoUserWidget(
        icon: Icons.location_on, value: user.address);
  }

  Row _buildItemInfoUserWidget(
      {required IconData icon, required String value}) {
    return Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
      Icon(icon),
      defaultPadding.horizontalSpace,
      Expanded(
        child: Text(
          value,
          style: context.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    ]);
  }

  _buildExpiryWidget(UserModel user) {
    return Text(
      Ultils.subcriptionEndDate(user.expiredAt) <= 0
          ? 'Đã hết hạn'
          : 'Còn ${Ultils.subcriptionEndDate(user.expiredAt)} ngày sử dụng!'
              .toUpperCase(),
      style: context.bodyMedium!.copyWith(
        color: Ultils.subcriptionEndDate(user.expiredAt) <= 10
            ? Colors.red
            : Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  _buildExtendedDateWidget(UserModel user) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Ngày gia hạn: ',
            style: context.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: Ultils.formatDateToString(user.extendedAt),
            style: context.bodyMedium,
          ),
        ],
      ),
    );
  }

  _buildExpiryDateWidget(UserModel user) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: 'Ngày hết hạn: ',
            style: context.bodyMedium!.copyWith(fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: Ultils.formatDateToString(user.expiredAt),
            style: context.bodyMedium,
          ),
        ],
      ),
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
    return InkWell(
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
                    style: titleStyle ?? context.bodyMedium,
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
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
