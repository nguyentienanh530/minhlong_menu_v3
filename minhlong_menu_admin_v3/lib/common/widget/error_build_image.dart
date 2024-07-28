import 'package:flutter/widgets.dart';

import '../../core/app_colors.dart';
import '../../core/app_style.dart';

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
      color: color ?? AppColors.smokeWhite,
      child: Center(
        child: FittedBox(
          child: Text(
            '(>_<)',
            style: kSubHeadingStyle.copyWith(
              color: tintcolor ?? AppColors.smokeWhite1,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }
}
