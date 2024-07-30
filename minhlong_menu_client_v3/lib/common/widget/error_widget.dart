// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

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
    return Center(
      child: Card(
        elevation: 4,
        shadowColor: context.colorScheme.onSurface.withOpacity(0.5),
        child: FittedBox(
          child: SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                children: [
                  Icon(Icons.error,
                      color: context.colorScheme.tertiaryContainer, size: 60),
                  10.verticalSpace,
                  Text(
                    error ?? "Có lỗi xảy ra",
                    style: context.bodyMedium!.copyWith(
                      color: context.bodyMedium!.color!.withOpacity(0.5),
                    ),
                  ),
                  10.verticalSpace,
                  FilledButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                      ),
                      icon: const Icon(Icons.refresh, size: 15),
                      onPressed: onRetryPressed,
                      label: Text('Thử lại', style: context.bodyMedium))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
