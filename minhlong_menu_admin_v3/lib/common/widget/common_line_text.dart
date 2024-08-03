import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

// import 'widgets.dart';

class CommonLineText extends StatelessWidget {
  final String? title, value;
  final Color? color;
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
      this.valueStyle});
  @override
  Widget build(BuildContext context) {
    return FittedBox(
        child: RichText(
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
                text: title ?? "",
                style: titleStyle ?? context.titleStyleMedium,
                children: <TextSpan>[
                  TextSpan(
                      text: value ?? '',
                      style: valueStyle ??
                          context.titleStyleMedium!
                              .copyWith(color: color ?? Colors.white))
                ])));
  }
}
