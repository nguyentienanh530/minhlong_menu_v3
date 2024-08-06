import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

Widget errorBuilderForImage(context, error, stackTrace) {
  return const ImageNotFound();
}

class ImageNotFound extends StatelessWidget {
  final Color? color;
  final Color? tintcolor;

  const ImageNotFound({
    super.key,
    this.color,
    this.tintcolor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color ?? Colors.white54.withOpacity(0.3),
      child: Center(
        child: FittedBox(
          child: Text(
            '(>_<)',
            style: context.titleStyleMedium!.copyWith(
              color: tintcolor ?? Colors.white54,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
