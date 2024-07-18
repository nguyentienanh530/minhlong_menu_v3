import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';
import '../widget/loading_widget.dart';

class AppDialog {
  static Future<dynamic> showErrorDialog(BuildContext context,
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultBorderRadius,
            ),
          ),
          title: Column(
            children: [
              const Icon(
                Icons.warning_rounded,
                color: Colors.redAccent,
                size: 80,
              ),
              const SizedBox(height: defaultPadding),
              Text(
                title ?? 'Lỗi!',
                style: kHeadingStyle.copyWith(
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
                style: kSubHeadingStyle.copyWith(
                    fontSize: 14, color: AppColors.black.withOpacity(0.5)),
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
                          backgroundColor: AppColors.themeColor,
                          foregroundColor: AppColors.white,
                        ),
                        onPressed: onPressedComfirm,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            confirmText ?? "Đăng xuất",
                            style: kButtonWhiteStyle,
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
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              defaultBorderRadius,
            ),
          ),
          title: Column(
            children: [
              const Icon(
                Icons.check_circle,
                color: AppColors.islamicGreen,
                size: 80,
              ),
              const SizedBox(height: defaultPadding),
              Text(
                title ?? 'Thành công!',
                style: kHeadingStyle.copyWith(
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
                style: kSubHeadingStyle.copyWith(
                    fontSize: 14, color: AppColors.black.withOpacity(0.5)),
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
                          backgroundColor: AppColors.themeColor,
                          foregroundColor: AppColors.white,
                        ),
                        onPressed: onPressedComfirm,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            confirmText!,
                            style: kButtonWhiteStyle,
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
                            color: AppColors.themeColor,
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
