import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                const Card(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                  ),
                )
              ],
            ),
          )),
    );
  }
}
