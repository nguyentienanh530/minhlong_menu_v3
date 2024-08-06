import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: context.colorScheme.primary,
            strokeWidth: 5,
            strokeCap: StrokeCap.round,
            semanticsValue: 'Loading...',
          ),
        ),
        const SizedBox(height: 15),
        Text(
          title,
          style: context.titleStyleMedium,
        ),
      ],
    );
  }
}
