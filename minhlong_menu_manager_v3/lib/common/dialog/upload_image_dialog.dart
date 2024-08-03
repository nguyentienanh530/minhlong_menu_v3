import 'package:flutter/material.dart';
import 'package:minhlong_menu_manager_v3/core/extensions.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';

class UploadImageWidget extends StatelessWidget {
  const UploadImageWidget({super.key, this.imageName, this.progress});
  final String? imageName;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: AppColors.lavender,
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.file_present_rounded,
                    color: context.colorScheme.primary),
                const SizedBox(width: defaultPadding),
                Expanded(
                  child: Text(
                    imageName ?? '',
                    maxLines: 2,
                  ),
                )
              ],
            ),
            const SizedBox(height: defaultPadding),
            SizedBox(
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 5,
                    child: LinearProgressIndicator(
                      value: progress,
                      borderRadius: BorderRadius.circular(defaultPadding),
                      color: context.colorScheme.primary,
                      backgroundColor: AppColors.smokeWhite,

                      // value: _userController.uploadProgress.value,
                    ),
                  ),
                  Expanded(
                      child: Center(
                    child: Text(
                      '${(progress! * 100).toStringAsFixed(0)}%',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
