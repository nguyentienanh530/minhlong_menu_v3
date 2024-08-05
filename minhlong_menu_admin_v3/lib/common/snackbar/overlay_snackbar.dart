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
            width: 300,
            decoration: BoxDecoration(
                color: type == OverlaySnackbarType.error
                    ? Colors.red.withOpacity(0.3)
                    : Colors.green.withOpacity(0.3),
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          type == OverlaySnackbarType.error
                              ? const Icon(Icons.error,
                                  color: Colors.red, size: 20)
                              : const Icon(Icons.check_circle,
                                  color: Colors.green, size: 20),
                          const SizedBox(width: 10),
                          FittedBox(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  type == OverlaySnackbarType.error
                                      ? 'Lỗi!'
                                      : 'Thành công!',
                                  style: context.titleStyleMedium!.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  message,
                                  style: context.bodySmall!.copyWith(
                                      color: context.bodyMedium!.color!
                                          .withOpacity(0.5)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    10.verticalSpace,
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: LinearTimer(
                        color: type == OverlaySnackbarType.error
                            ? Colors.red
                            : Colors.green,
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
                    child:
                        const Icon(Icons.close, color: Colors.white, size: 20),
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
