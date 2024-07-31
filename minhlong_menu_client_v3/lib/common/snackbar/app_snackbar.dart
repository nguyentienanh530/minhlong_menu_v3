import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

class AppSnackbar {
  static Future showSnackBar(BuildContext context,
      {String? msg, bool isSuccess = false}) async {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          showCloseIcon: true,
          content: Row(
            children: [
              Icon(isSuccess ? Icons.check : Icons.error,
                  color: context.bodyMedium!.color),
              10.horizontalSpace,
              Text(msg ?? ''),
            ],
          ),
          backgroundColor: isSuccess
              ? context.colorScheme.primaryContainer
              : context.colorScheme.tertiaryContainer,
          duration: const Duration(seconds: 3),
        ),
      );
  }
}
