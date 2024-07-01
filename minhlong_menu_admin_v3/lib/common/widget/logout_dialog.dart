import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({
    super.key,
    required this.title,
    required this.onRetryPressed,
  });

  final String title;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        // side: BorderSide(color: Colors.redAccent, width: 2.0),
        borderRadius: BorderRadius.circular(defaultBorderRadius),
      ),
      title: Column(
        children: [
          const Icon(Icons.warning_rounded, color: Colors.redAccent, size: 80),
          const SizedBox(height: defaultPadding),
          Text(
            "Đăng xuất",
            style: kHeadingStyle.copyWith(fontWeight: FontWeight.bold),
          )
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: kSubHeadingStyle.copyWith(
                fontSize: 14, color: AppColors.black.withOpacity(0.5)),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.themeColor),
                ),
                onPressed: () => Navigator.pop(context),
                child: const Text("Hủy"),
              ),
              const SizedBox(width: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    foregroundColor: AppColors.white),
                onPressed: onRetryPressed,
                child: const Text("Đăng xuất"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
