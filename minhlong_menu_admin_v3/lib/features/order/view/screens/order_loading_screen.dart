import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

class OrderLoadingScreen extends StatelessWidget {
  const OrderLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: AppColors.smokeWhite1,
        highlightColor: AppColors.smokeWhite2,
        child: Padding(
          padding: const EdgeInsets.all(30).r,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                context.isMobile
                    ? Column(children: [
                        Row(
                          children: [
                            Expanded(child: _buildContainer(cHeight: 35)),
                            10.horizontalSpace,
                          ],
                        ),
                        _buildContainer(cHeight: 35, cWidth: 100),
                      ])
                    : Row(
                        children: [
                          Expanded(
                            child: _buildContainer(cHeight: 35),
                          ),
                          10.horizontalSpace,
                          _buildContainer(cHeight: 35, cWidth: 100),
                        ],
                      ),
                20.verticalSpace,
                Expanded(child: _buildContainer(cWidth: double.infinity)),
              ]),
        ),
      ),
    );
  }

  Widget _buildContainer({double? cHeight, double? cWidth}) {
    return Container(
      height: cHeight,
      width: cWidth,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(textFieldBorderRadius).r),
    );
  }
}
