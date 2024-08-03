import 'package:flutter/material.dart';
import 'package:minhlong_menu_manager_v3/core/extensions.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';

class RetryDialog extends StatelessWidget {
  const RetryDialog({
    super.key,
    required this.title,
    required this.onRetryPressed,
    this.onRetryText,
  });

  final String title;
  final String? onRetryText;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius)),
      title: Column(
        children: [
          const Icon(Icons.error, color: Colors.redAccent, size: 80),
          const SizedBox(height: defaultPadding),
          Text(
            "Có lỗi xảy ra",
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
              // OutlinedButton(
              //   style: OutlinedButton.styleFrom(
              //     side: const BorderSide(color: context.colorScheme.primary),
              //   ),
              //   onPressed: () => Navigator.pop(context),
              //   child: const Text("Hủy"),
              // ),
              const SizedBox(width: 15),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: AppColors.white),
                onPressed: onRetryPressed,
                child: Text(onRetryText ?? "Thử lại", style: kButtonWhiteStyle),
              ),
            ],
          )
        ],
      ),
    );
  }
}
