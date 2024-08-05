import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:minhlong_menu_manager_v3/core/app_colors.dart';
import 'package:minhlong_menu_manager_v3/core/app_style.dart';

enum OverlaySnackbarType { success, error }

class OverlaySnackbar {
  OverlaySnackbar._();
  static final OverlaySnackbar _instance = OverlaySnackbar._();
  static OverlaySnackbar get instance => _instance;

  static void show(
    BuildContext context,
    String message, {
    OverlaySnackbarType type = OverlaySnackbarType.success,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 50,
        right: 10,
        child: Material(
          // adding transparent to apply custom border
          color: Colors.transparent,
          child: Container(
            height: 80,
            width: 300,
            decoration: BoxDecoration(
                color: type == OverlaySnackbarType.error
                    ? AppColors.red.withOpacity(0.3)
                    : AppColors.islamicGreen.withOpacity(0.3),
                borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          type == OverlaySnackbarType.error
                              ? const Icon(Icons.error,
                                  color: AppColors.red, size: 20)
                              : const Icon(Icons.check_circle,
                                  color: AppColors.islamicGreen, size: 20),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                type == OverlaySnackbarType.error
                                    ? 'Lỗi!'
                                    : 'Thành công!',
                                style: kSubHeadingWhiteStyle.copyWith(
                                    fontWeight: FontWeight.w700),
                              ),
                              Text(
                                message,
                                style: kBodyWhiteStyle,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: LinearTimer(
                        color: type == OverlaySnackbarType.error
                            ? AppColors.red
                            : AppColors.islamicGreen,
                        duration: const Duration(seconds: 3),
                        onTimerEnd: () {
                          overlayEntry.remove();
                        },
                        forward: false,
                      ),
                    )
                  ],
                ),
                Positioned(
                  top: 0,
                  right: 0,
                  child: InkWell(
                    child: const Icon(Icons.close,
                        color: AppColors.white, size: 20),
                    onTap: () {
                      overlayEntry.remove();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }
}
