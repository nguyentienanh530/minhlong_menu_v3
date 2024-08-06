import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/app_const.dart';

class TCBLoadingScreen extends StatelessWidget {
  const TCBLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.white54,
        child: Padding(
          padding: const EdgeInsets.all(30).r,
          child: Column(
            children: [
              context.isMobile
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        10.verticalSpace,
                        _buildContainer(cHeight: 40, cWidth: 100.h),
                        10.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // Expanded(
                            //     flex: 3,
                            //     child: _buildContainer(
                            //         cHeight: 40, cWidth: 400.h)),
                            // 16.horizontalSpace,
                            Expanded(
                              child:
                                  _buildContainer(cHeight: 40, cWidth: 130.h),
                            )
                          ],
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        10.horizontalSpace,
                        _buildContainer(cHeight: 40, cWidth: 100.h),
                        30.horizontalSpace,
                        // _buildContainer(cHeight: 40, cWidth: 400.h),
                        // 30.horizontalSpace,
                        _buildContainer(cHeight: 40, cWidth: 130.h),
                        30.horizontalSpace,
                      ],
                    ),
              20.verticalSpace,
              Expanded(
                  child: _buildContainer(
                      cHeight: double.infinity, cWidth: double.infinity)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContainer({double? cHeight, double? cWidth}) {
    return Container(
      height: cHeight,
      width: cWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(textFieldBorderRadius).r),
    );
  }
}
