import 'package:flutter/widgets.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

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
      color: color ?? context.colorScheme.onPrimary,
      child: Center(
        child: FittedBox(
          child: Text(
            '(>_<)'.toUpperCase(),
            style: context.titleStyleSmall!.copyWith(
              fontSize: 50,
            ),
          ),
        ),
      ),
    );
  }
}
