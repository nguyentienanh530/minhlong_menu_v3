import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/Routes/app_route.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_asset.dart';

class SuccessScreen extends StatelessWidget {
  const SuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Thành Công',
          style: context.titleStyleLarge!.copyWith(fontWeight: FontWeight.w700),
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
                  style: context.titleStyleLarge!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                30.verticalSpace,
                Text(
                  'Đơn hàng của bạn đã được \n đặt thành công',
                  textAlign: TextAlign.center,
                  style: context.bodyMedium!.copyWith(
                      color: context.bodyMedium!.color!.withOpacity(0.5)),
                )
              ],
            ),
            Positioned(
              bottom: 50,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                ),
                onPressed: () {
                  context.go(AppRoute.home);
                },
                child: Text(
                  'Trở lại'.toUpperCase(),
                  style: context.bodyMedium!.copyWith(
                    color: Colors.white,
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
