import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../core/app_asset.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';

class EmptyScreen extends StatelessWidget {
  const EmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
            children: [
          Container(
              decoration: const BoxDecoration(
                  color: Colors.black38, shape: BoxShape.circle),
              margin: const EdgeInsets.all(defaultPadding),
              child: Image.asset(AppAsset.emptyImage)),
          const SizedBox(height: 16),
          Center(
              child: Text("Không có sản phẩm",
                  style: kSubHeadingStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 20))),
          const SizedBox(height: 16),
          Center(
              child: Text(
                  "Xin lỗi, chúng tôi không thể tìm thấy bất kỳ kết quả nào cho mặt hàng của bạn.",
                  style: kSubHeadingStyle,
                  textAlign: TextAlign.center))
        ]
                .animate(interval: 50.ms)
                .slideX(
                    begin: -0.1,
                    end: 0,
                    curve: Curves.easeInOutCubic,
                    duration: 500.ms)
                .fadeIn(curve: Curves.easeInOutCubic, duration: 500.ms)));
  }
}
