import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_string.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/app_asset.dart';
import '../../../../core/app_style.dart';

class SettingLoadingScreen extends StatelessWidget {
  const SettingLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
          baseColor: AppColors.smokeWhite1,
          highlightColor: AppColors.smokeWhite2,
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 2),
            width: double.infinity,
            child: context.isMobile
                ? Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(children: [
                      Container(
                        padding: const EdgeInsets.all(defaultPadding),
                        width: 0.25 * context.sizeDevice.height,
                        height: 0.25 * context.sizeDevice.height,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.white),
                        child: SizedBox(
                          height: 0.25 * context.sizeDevice.height,
                        ),
                      ),
                      20.verticalSpace,
                      Container(
                        height: 25,
                        width: 200,
                        color: AppColors.white,
                      ),
                      10.verticalSpace,
                      Container(
                        height: 15,
                        width: 100,
                        color: AppColors.white,
                      ),
                      _ItemProfile(
                          svgPath: AppAsset.user,
                          title: AppString.editProfile,
                          onTap: () {}),
                      _ItemProfile(
                          svgPath: AppAsset.user,
                          title: AppString.editProfile,
                          onTap: () {}),
                      _ItemProfile(
                          svgPath: AppAsset.user,
                          title: AppString.editProfile,
                          onTap: () {}),
                    ]))
                : Row(
                    children: [
                      const Spacer(),
                      Expanded(
                          flex: 2,
                          child: Container(
                              constraints: const BoxConstraints(maxWidth: 600),
                              child: Column(children: [
                                Container(
                                  padding: const EdgeInsets.all(defaultPadding),
                                  width: 0.25 * context.sizeDevice.height,
                                  height: 0.25 * context.sizeDevice.height,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.white),
                                  child: SizedBox(
                                    height: 0.25 * context.sizeDevice.height,
                                  ),
                                ),
                                20.verticalSpace,
                                Container(
                                  height: 25,
                                  width: 200,
                                  color: AppColors.white,
                                ),
                                10.verticalSpace,
                                Container(
                                  height: 15,
                                  width: 100,
                                  color: AppColors.white,
                                ),
                                _ItemProfile(
                                    svgPath: AppAsset.user,
                                    title: AppString.editProfile,
                                    onTap: () {}),
                                _ItemProfile(
                                    svgPath: AppAsset.user,
                                    title: AppString.editProfile,
                                    onTap: () {}),
                                _ItemProfile(
                                    svgPath: AppAsset.user,
                                    title: AppString.editProfile,
                                    onTap: () {}),
                              ]))),
                      const Spacer(),
                    ],
                  ),
          )),
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
