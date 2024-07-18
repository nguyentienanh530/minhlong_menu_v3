import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';

import '../../core/app_asset.dart';

class NoProduct extends StatelessWidget {
  const NoProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(
          left: defaultPadding,
          right: defaultPadding,
          bottom: defaultPadding * 2),
      height: double.infinity,
      child: Image.asset(
        AppAsset.noProductImage,
      ),
    );
  }
}
