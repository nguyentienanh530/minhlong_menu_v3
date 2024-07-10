import 'package:flutter/material.dart';

import '../../core/app_colors.dart';
import '../../core/app_style.dart';

// import 'widgets.dart';

class CommonLineText extends StatelessWidget {
  final String? title, value;
  final Color? color;
  final int? maxLines;
  final TextStyle? titleStyle;
  final TextStyle? valueStyle;

  final bool? isDarkText;
  const CommonLineText(
      {super.key,
      this.title,
      this.value,
      this.color,
      this.titleStyle,
      this.isDarkText = false,
      this.valueStyle,
      this.maxLines});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: RichText(
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: title ?? "",
                style: titleStyle ?? kSubHeadingStyle,
                children: <TextSpan>[
                  TextSpan(
                      text: value ?? '',
                      style: valueStyle ??
                          kSubHeadingStyle.copyWith(
                              color: color ?? AppColors.white))
                ])));
  }
}
