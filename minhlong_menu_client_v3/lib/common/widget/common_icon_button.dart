import 'package:flutter/material.dart';

import '../../core/app_colors.dart';

class CommonIconButton extends StatelessWidget {
  const CommonIconButton(
      {super.key,
      required this.onTap,
      this.color,
      this.icon,
      this.tooltip,
      this.size,
      this.iconSize});
  final void Function()? onTap;
  final Color? color;
  final IconData? icon;
  final String? tooltip;
  final double? size;
  final double? iconSize;
  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip ?? '',
      child: InkWell(
        onTap: onTap,
        child: Container(
          height: size ?? 30,
          width: size ?? 30,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
              color: color?.withOpacity(0.2) ??
                  AppColors.themeColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: color ?? AppColors.themeColor)),
          child: Icon(icon ?? Icons.remove_red_eye,
              color: color ?? AppColors.themeColor, size: iconSize ?? 20),
        ),
      ),
    );
  }
}
