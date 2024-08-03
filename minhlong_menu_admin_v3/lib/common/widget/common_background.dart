import 'package:flutter/material.dart';

import '../../core/app_asset.dart';

class CommonBackground extends StatelessWidget {
  const CommonBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Image.asset(AppAsset.background,
          color: Colors.black.withOpacity(0.15)),
    );
  }
}
