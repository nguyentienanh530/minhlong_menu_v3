import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_style.dart';

enum OverlaySnackbarType { success, error }

void showOverlaySnackbar(BuildContext context, String message,
    {OverlaySnackbarType type = OverlaySnackbarType.success}) {
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
                  ? AppColors.red.withOpacity(0.5)
                  : AppColors.islamicGreen.withOpacity(0.5),
              borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                        type == OverlaySnackbarType.error
                            ? Icons.error
                            : Icons.check_circle,
                        color: AppColors.white,
                        size: 16),
                    const SizedBox(width: 10),
                    Text(
                      message,
                      style: kBodyWhiteStyle,
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close,
                          color: Colors.white, size: 15),
                      onPressed: () {
                        overlayEntry.remove();
                      },
                    ),
                  ],
                ),
              ),
              10.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: LinearTimer(
                  duration: const Duration(seconds: 3),
                  onTimerEnd: () {
                    overlayEntry.remove();
                  },
                  forward: false,
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );

  overlay.insert(overlayEntry);
}
