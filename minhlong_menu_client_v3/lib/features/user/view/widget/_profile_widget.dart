part of '../screen/profile_screen.dart';

extension _ProfileWidget on _ProfileScreenState {
  Widget _bodyInfoUser({required UserModel userModel}) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.lavender,
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
                onTap: () async => await context
                        .push(AppRoute.editProfile, extra: userModel)
                        .then((value) {
                      context.read<UserBloc>().add(UserFetched());
                    }),
                svgPath: AppAsset.user,
                title: AppString.editProfile),
            _ItemProfile(
                svgPath: AppAsset.lock,
                title: AppString.changePassword,
                onTap: () => context.push(AppRoute.changePassword)),
            // _buildItemPrint(context),
            _ItemProfile(
                svgPath: AppAsset.logout,
                title: 'Đăng xuất',
                onTap: () => _showDialogLogout()),
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

//   Widget _buildItemPrint(BuildContext context) {
//     return ValueListenableBuilder(
//       valueListenable: _isUsePrinter,
//       builder: (context, value, child) {
//         return Column(
//           children: [
//             Card(
//                 elevation: 4,
//                 shadowColor: AppColors.lavender,
//                 child: SizedBox(
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                       Expanded(
//                         child: FittedBox(
//                           alignment: Alignment.centerLeft,
//                           fit: BoxFit.scaleDown,
//                           child: Row(children: [
//                             Padding(
//                                 padding: const EdgeInsets.all(defaultPadding),
//                                 child: SvgPicture.asset(AppAsset.print,
//                                     colorFilter: const ColorFilter.mode(
//                                         AppColors.themeColor,
//                                         BlendMode.srcIn))),
//                             Text(
//                               AppString.usePrinter,
//                               style: kBodyStyle.copyWith(
//                                   color: AppColors.secondTextColor),
//                             )
//                           ]),
//                         ),
//                       ),
//                       Expanded(
//                         child: FittedBox(
//                           alignment: Alignment.centerRight,
//                           fit: BoxFit.scaleDown,
//                           child: Transform.scale(
//                             scale: 0.8,
//                             child: Switch(
//                               activeTrackColor: AppColors.themeColor,
//                               inactiveTrackColor:
//                                   AppColors.themeColor.withOpacity(0.5),
//                               inactiveThumbColor: AppColors.white,
//                               value: _isUsePrinter.value,
//                               onChanged: (value) {
//                                 _isUsePrinter.value = !_isUsePrinter.value;
//                               },
//                             ),
//                           ),
//                         ),
//                       ),
//                     ]))),
//             _isUsePrinter.value
//                 ? Padding(
//                     padding:
//                         const EdgeInsets.symmetric(horizontal: defaultPadding),
//                     child: _ItemProfile(
//                         svgPath: AppAsset.fileConfig,
//                         title: AppString.settingPrinter,
//                         titleStyle: kBodyStyle.copyWith(
//                             color: AppColors.secondTextColor),
//                         onTap: () {
//                           //  context.push(RouteName.printSeting)
//                         }),
//                   )
//                 : const SizedBox()
//           ],
//         );
//       },
//     );
//   }
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
