import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

class CommonIconButton extends StatelessWidget {
  const CommonIconButton(
      {super.key, required this.onTap, this.color, this.icon, this.tooltip});
  final void Function()? onTap;
  final Color? color;
  final IconData? icon;
  final String? tooltip;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: 40.h,
          width: 40.h,
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: color?.withOpacity(0.2) ??
                  context.colorScheme.primary.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: color ?? context.colorScheme.primary)),
          child: FittedBox(
            child: Icon(
              icon ?? Icons.remove_red_eye,
              color: color ?? context.colorScheme.primary,
            ),
          ),
        ),
      ),
    );
  }
}
