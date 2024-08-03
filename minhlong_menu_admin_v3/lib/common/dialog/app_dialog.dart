import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:minhlong_menu_admin_v3/core/app_asset.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../core/app_const.dart';
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultBorderRadius,
            ),
          ),
          title: Column(
            children: [
              Icon(
                Icons.warning_rounded,
                color: context.colorScheme.error,
                size: 80,
              ),
              const SizedBox(height: defaultPadding),
              Text(
                title ?? 'Lỗi!',
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
                style: context.titleStyleLarge!.copyWith(
                    fontSize: 14,
                    color: context.titleStyleLarge!.color!.withOpacity(0.5)),
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
                                  style: context.bodyMedium,
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
                          foregroundColor: Colors.white,
                        ),
                        onPressed: onPressedComfirm,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            confirmText ?? "Đăng xuất",
                            style: context.bodyMedium!
                                .copyWith(color: Colors.white),
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

  static Future<dynamic> showWarningDialog(BuildContext context,
      {required void Function()? onPressedComfirm,
      String? title,
      String? description,
      String? cancelText,
      String? confirmText,
      bool haveCancelButton = true}) {
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
              Lottie.asset(
                AppAsset.warningAnimation,
                decoder: LottieComposition.decodeGZip,
                width: 150,
                height: 150,
                fit: BoxFit.fill,
              ),
              const SizedBox(height: defaultPadding),
              Text(
                title ?? 'Cảnh báo!',
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
                style: context.titleStyleMedium!.copyWith(
                    fontSize: 14,
                    color: context.titleStyleMedium!.color!.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    haveCancelButton
                        ? Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(
                                    // color: AppColors.red,
                                    ),
                              ),
                              onPressed: () => Navigator.pop(context),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  cancelText ?? "Huỷ",
                                  style: context.bodyMedium,
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
                          foregroundColor: Colors.white,
                        ),
                        onPressed: onPressedComfirm,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            confirmText ?? 'Xác nhận',
                            style: context.bodyMedium!
                                .copyWith(color: Colors.white),
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
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 80,
              ),
              const SizedBox(height: defaultPadding),
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
                style: context.titleStyleMedium!.copyWith(
                    fontSize: 14,
                    color: context.titleStyleMedium!.color!.withOpacity(0.5)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: onPressedComfirm,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            confirmText!,
                            style: context.bodyMedium!
                                .copyWith(color: Colors.white),
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
      builder: (context) => AlertDialog(
        scrollable: true,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}
