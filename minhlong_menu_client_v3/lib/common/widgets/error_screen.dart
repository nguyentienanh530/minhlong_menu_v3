import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_asset.dart';
import '../../core/app_const.dart';
import '../../core/app_string.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({super.key, this.errorMessage});
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sizeDevice.width,
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(
            flex: 2,
          ),
          Expanded(
            flex: 4,
            child: Image.asset(
              AppAsset.errorImageScreen,
              fit: BoxFit.scaleDown,
              filterQuality: FilterQuality.high,
            ),
          ),
          Expanded(
            child: Text(errorMessage ?? '',
                style:
                    context.bodyMedium!.copyWith(fontWeight: FontWeight.bold)),
          ),
          const Spacer(
            flex: 2,
          ),
          Expanded(
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  elevation: 4,
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding * 4),
                ),
                onPressed: () => context.pop(),
                child: Text(
                  AppString.back,
                  style: context.bodyMedium,
                )),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
