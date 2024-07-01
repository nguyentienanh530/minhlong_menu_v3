import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../../core/app_style.dart';

class CommonTitleAppbar extends StatelessWidget {
  const CommonTitleAppbar({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TypewriterAnimatedText(title,
            textStyle: kHeadingStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 30),
            speed: const Duration(milliseconds: 100)),
      ],
      isRepeatingAnimation: false,
    );
  }
}
