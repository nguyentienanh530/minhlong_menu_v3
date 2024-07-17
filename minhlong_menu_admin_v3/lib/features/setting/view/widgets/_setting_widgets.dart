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
      onTap: () async =>
          context.push<bool>(AppRoute.editProfile, extra: user).then((value) {
        if (value != null && value) {
          context.read<UserBloc>().add(UserFetched());
        }
      }),
      colorIcon: AppColors.themeColor,
      svgPath: AppAsset.user,
      title: AppString.editProfile,
    );
  }

  Widget _buildTitleChangePassword() {
    return _ItemProfile(
      onTap: () => _showChangePasswordDialog(),
      colorIcon: AppColors.themeColor,
      svgPath: AppAsset.lock,
      title: AppString.changePassword,
    );
  }

  Widget _buildItemPrint(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isUsePrinter,
      builder: (context, value, child) {
        return Card(
          elevation: 4,
          child: Column(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 2,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.centerLeft,
                            child: Row(children: [
                              Padding(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  child: SvgPicture.asset(AppAsset.print,
                                      colorFilter: const ColorFilter.mode(
                                          AppColors.themeColor,
                                          BlendMode.srcIn))),
                              Text(
                                AppString.usePrinter,
                                style: kBodyStyle.copyWith(
                                    color: AppColors.secondTextColor),
                              )
                            ]),
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: Switch(
                            activeTrackColor: AppColors.themeColor,
                            inactiveTrackColor:
                                AppColors.themeColor.withOpacity(0.5),
                            inactiveThumbColor: AppColors.white,
                            value: _isUsePrinter.value,
                            onChanged: (value) {
                              _isUsePrinter.value = !_isUsePrinter.value;
                            },
                          ),
                        ),
                      ])),
              _isUsePrinter.value
                  ? _ItemProfile(
                      svgPath: AppAsset.fileConfig,
                      title: AppString.settingPrinter,
                      onTap: () {})
                  : const SizedBox()
            ],
          ),
        );
      },
    );
  }

  _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: AppColors.white,
        child: FittedBox(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: const ChangePassword(),
          ),
        ),
      ),
    );
  }
}

class _ItemProfile extends StatelessWidget {
  const _ItemProfile({
    required this.svgPath,
    required this.title,
    required this.onTap,
    this.colorIcon,
  });
  final Color? colorIcon;
  final String svgPath;
  final String title;

  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        // borderRadius: BorderRadius.circular(defaultBorderRadius),
        onTap: onTap,
        child: SizedBox(
          height: 50,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 2,
                child: FittedBox(
                  alignment: Alignment.centerLeft,
                  fit: BoxFit.scaleDown,
                  child: Row(
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: SvgPicture.asset(svgPath,
                              colorFilter: const ColorFilter.mode(
                                  Colors.red, BlendMode.srcIn))),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          title,
                          style: kBodyStyle.copyWith(
                              color: AppColors.secondTextColor),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: defaultPadding),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: colorIcon ?? AppColors.secondTextColor,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
