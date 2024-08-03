// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:minhlong_menu_manager_v3/core/app_const.dart';

import '../../core/app_colors.dart';
import '../../core/app_style.dart';

class ErrWidget extends StatelessWidget {
  const ErrWidget({
    super.key,
    this.error,
    this.onRetryPressed,
  });
  final String? error;
  final Function()? onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.lavender,
      child: FittedBox(
        child: SizedBox(
          width: 300,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              children: [
                const Icon(Icons.error, color: Colors.redAccent, size: 60),
                const SizedBox(height: 10),
                Text(
                  error ?? "Có lỗi xảy ra",
                  style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
                ),
                const SizedBox(height: 10),
                FilledButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                    ),
                    icon: const Icon(Icons.refresh, size: 15),
                    onPressed: onRetryPressed,
                    label: const Text('Thử lại', style: kButtonWhiteStyle))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
