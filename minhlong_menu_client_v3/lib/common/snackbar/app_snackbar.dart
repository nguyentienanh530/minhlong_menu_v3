import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_colors.dart';

class AppSnackbar {
  static Future showSnackBar(BuildContext context,
      {String? msg, bool isSuccess = false}) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        showCloseIcon: true,
        content: Row(
          children: [
            Icon(isSuccess ? Icons.check : Icons.error, color: Colors.white),
            10.horizontalSpace,
            Text(msg ?? ''),
          ],
        ),
        backgroundColor: isSuccess ? AppColors.islamicGreen : AppColors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }
}
