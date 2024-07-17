part of '../screen/profile_screen.dart';

extension _ProfileWidget on _ProfileScreenState {
  Widget imageProfileWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(2),
          width: double.infinity,
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
              imageUrl: _userList[0].image ?? '',
              errorWidget: errorBuilderForImage,
              placeholder: (context, url) => const Loading(),
            ),
          ),
        ),
        10.verticalSpace,
        _textBotton()
      ],
    );
  }

  Widget _textBotton() {
    return Column(
      children: [
        Text(
          _userList[0].name.toString(),
          style:
              kHeadingStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          '+84 ${_userList[0].phone}',
          style: kBodyStyle.copyWith(
              color: AppColors.secondTextColor, fontSize: 12),
        ),
      ],
    );
  }

  Widget _bodyInfoUser() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ItemProfile(
              onTap: () => context.push(AppRoute.editProfile),
              svgPath: AppAsset.user,
              title: AppString.editProfile),
          _ItemProfile(
              svgPath: AppAsset.lock,
              title: AppString.changePassword,
              onTap: () => context.push(AppRoute.changePassword)),
          _buildItemPrint(context)
        ],
      ),
    );
  }

  Widget _buildItemPrint(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isUsePrinter,
      builder: (context, value, child) {
        return Column(
          children: [
            Card(
                elevation: 4,
                shadowColor: AppColors.lavender,
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
                      Expanded(
                        child: FittedBox(
                          alignment: Alignment.centerRight,
                          fit: BoxFit.scaleDown,
                          child: Transform.scale(
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
                        ),
                      ),
                    ]))),
            _isUsePrinter.value
                ? Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: defaultPadding),
                    child: _ItemProfile(
                        svgPath: AppAsset.fileConfig,
                        title: AppString.settingPrinter,
                        titleStyle: kBodyStyle.copyWith(
                            color: AppColors.secondTextColor),
                        onTap: () {
                          //  context.push(RouteName.printSeting)
                        }),
                  )
                : const SizedBox()
          ],
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
        elevation: 4,
        shadowColor: AppColors.lavender,
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
                              colorFilter: const ColorFilter.mode(
                                  Colors.red, BlendMode.srcIn))),
                      Text(
                        title,
                        style: titleStyle ??
                            kBodyStyle.copyWith(
                                color: AppColors.secondTextColor),
                      )
                    ]),
                  ),
                ),
                Expanded(
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: colorIcon ?? AppColors.secondTextColor,
                        )),
                  ),
                )
              ])),
        ));
  }
}
