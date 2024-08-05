import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

enum AppSnackbarType { success, error }

class AppSnackbar {
  static Future showSnackBar(BuildContext context,
      {String? msg, AppSnackbarType type = AppSnackbarType.error}) async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          showCloseIcon: true,
          closeIconColor: Colors.white,
          content: Row(
            children: [
              Icon(
                type == AppSnackbarType.success ? Icons.check : Icons.error,
                color: Colors.white,
              ),
              10.horizontalSpace,
              Text(msg ?? '',
                  style: context.bodyMedium!.copyWith(color: Colors.white)),
            ],
          ),
          backgroundColor: type == AppSnackbarType.success
              ? context.colorScheme.primary
              : context.colorScheme.error,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
