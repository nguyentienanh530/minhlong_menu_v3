// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

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
      shadowColor: Colors.white54,
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
                  style: context.bodyLarge!.copyWith(
                      color: context.bodyMedium!.color!.withOpacity(0.5)),
                ),
                const SizedBox(height: 10),
                FilledButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    icon: const Icon(Icons.refresh, size: 15),
                    onPressed: onRetryPressed,
                    label: Text('Thử lại', style: context.bodyMedium))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
