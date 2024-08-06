import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:linear_timer/linear_timer.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

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
            width: 350,
            decoration: BoxDecoration(
                color: type == OverlaySnackbarType.error
                    ? Colors.red[200]
                    : Colors.green[200],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            // padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        type == OverlaySnackbarType.error
                            ? const Icon(Icons.error,
                                color: Colors.red, size: 40)
                            : const Icon(Icons.check_circle,
                                color: Colors.green, size: 40),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                type == OverlaySnackbarType.error
                                    ? 'Lỗi!'
                                    : 'Thành công!',
                                style: context.titleStyleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              Text(
                                message,
                                style: context.bodySmall!.copyWith(
                                    color: Colors.black.withOpacity(0.8)),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          child: const Icon(Icons.close,
                              color: Colors.black, size: 20),
                          onTap: () {
                            overlayEntry.remove();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                10.verticalSpace,
                LinearTimer(
                  color: type == OverlaySnackbarType.error
                      ? Colors.red
                      : Colors.green,
                  duration: const Duration(seconds: 3),
                  onTimerEnd: () {
                    overlayEntry.remove();
                  },
                  forward: false,
                )
              ],
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
  }
}
