import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({super.key, this.onTap});
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 40,
          maxHeight: 40,
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
