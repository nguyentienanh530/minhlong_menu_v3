import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/app_style.dart';

import '../../core/app_colors.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            color: AppColors.themeColor,
            strokeWidth: 3,
            strokeCap: StrokeCap.round,
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
        ),
      ],
    );
  }
}
