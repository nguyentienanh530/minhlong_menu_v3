import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/Routes/app_route.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_asset.dart';
import '../../core/app_style.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Thành Công',
          style: kSubHeadingStyle.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: SizedBox(
        height: context.sizeDevice.height,
        width: context.sizeDevice.width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppAsset.successImageScreen,
                ),
                Text(
                  'ĐẶT THÀNH CÔNG',
                  style: kHeadingStyle.copyWith(fontWeight: FontWeight.w900),
                ),
                30.verticalSpace,
                Text(
                  'Đơn hàng của bạn đã được \n đặt thành công',
                  textAlign: TextAlign.center,
                  style:
                      kCaptionStyle.copyWith(color: AppColors.secondTextColor),
                )
              ],
            ),
            Positioned(
              // top: 0,
              // right: 0,
              bottom: 30,
              child: FilledButton(
                onPressed: () {
                  context.go(AppRoute.home);
                },
                child: Text('Trở lại'.toUpperCase(), style: kButtonWhiteStyle),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
