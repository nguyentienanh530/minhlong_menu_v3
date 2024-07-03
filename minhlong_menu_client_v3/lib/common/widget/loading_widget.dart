import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';

import '../../core/app_colors.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: AppColors.lavender,
      elevation: 4,
      child: SizedBox(
        height: 200,
        width: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                color: AppColors.themeColor,
                strokeWidth: 4,
                strokeCap: StrokeCap.round,
              ),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: kBodyStyle,
            ),
          ],
        ),
      ),
    );
  }
}
