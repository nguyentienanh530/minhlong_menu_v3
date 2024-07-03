import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    required this.title,
    this.description,
    required this.onTap,
    this.cancelText,
    this.confirmText,
    this.icon,
  });

  final String title;
  final String? description;
  final VoidCallback onTap;
  final String? cancelText;
  final String? confirmText;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          defaultBorderRadius,
        ),
      ),
      title: Column(
        children: [
          icon ??
              const Icon(
                Icons.warning_rounded,
                color: Colors.redAccent,
                size: 80,
              ),
          const SizedBox(height: defaultPadding),
          Text(
            title,
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
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: AppColors.themeColor,
                      ),
                    ),
                    onPressed: () => context.pop(),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        cancelText ?? "Hủy",
                        style: kButtonStyle,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.themeColor,
                      foregroundColor: AppColors.white,
                    ),
                    onPressed: onTap,
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
  }
}