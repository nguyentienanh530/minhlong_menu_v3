import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_const.dart';
import '../../core/app_string.dart';
import '../widget/loading_widget.dart';

class AppDialog {
  static Future<dynamic> showErrorDialog(BuildContext context,
      {required void Function()? onPressedComfirm,
      String? title,
      String? description,
      String? cancelText,
      String? confirmText,
      bool haveCancelButton = false}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          // backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultBorderRadius,
            ),
          ),
          title: Column(
            children: [
              Icon(
                Icons.warning_rounded,
                color: context.colorScheme.tertiaryContainer,
                size: 80,
              ),
              16.verticalSpace,
              Text(
                title ?? AppString.error,
                style: context.titleStyleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description ?? '',
                style: context.bodyMedium!.copyWith(
                  fontSize: 14,
                  color: context.bodyMedium!.color!.withOpacity(0.5),
                ),
                textAlign: TextAlign.center,
              ),
              15.verticalSpace,
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    haveCancelButton
                        ? Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide(
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  cancelText ?? "Huỷ",
                                  style: context.bodyLarge!.copyWith(
                                      color: context.colorScheme.primary),
                                ),
                              ),
                            ),
                          )
                        : const SizedBox(),
                    haveCancelButton ? 10.horizontalSpace : 0.horizontalSpace,
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary,
                        ),
                        onPressed: onPressedComfirm,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            confirmText ?? "Đăng xuất",
                            style: context.bodyLarge!
                                .copyWith(color: context.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> showSuccessDialog(BuildContext context,
      {required void Function()? onPressedComfirm,
      String? title,
      String? description,
      String? cancelText,
      String? confirmText}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultBorderRadius,
            ),
          ),
          title: Column(
            children: [
              Icon(
                Icons.check_circle,
                color: context.colorScheme.primaryContainer,
                size: 80,
              ),
              16.verticalSpace,
              Text(
                title ?? 'Thành công!',
                style: context.titleStyleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                description ?? '',
                style: context.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: context.bodyMedium!.color!.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
              15.verticalSpace,
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: context.colorScheme.onPrimary,
                        ),
                        onPressed: onPressedComfirm,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            confirmText!,
                            style: context.bodyLarge!
                                .copyWith(color: context.colorScheme.onPrimary),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  static Future<dynamic> showLoadingDialog(BuildContext context,
      {bool isProgressed = false, String? imageName, double? progressValue}) {
    return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: FittedBox(
          child: Container(
            padding: const EdgeInsets.all(defaultPadding),
            constraints: const BoxConstraints(maxWidth: 200),
            child: Column(
              children: [
                const LoadingWidget(
                  title: 'Đang xử lý...',
                ),
                isProgressed
                    ? Column(
                        children: [
                          10.verticalSpace,
                          Text(imageName ?? ''),
                          10.verticalSpace,
                          LinearProgressIndicator(
                            value: progressValue! / 100,
                            color: context.colorScheme.primary,
                          ),
                        ],
                      )
                    : const SizedBox()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
