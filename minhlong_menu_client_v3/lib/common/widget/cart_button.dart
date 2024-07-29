import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_asset.dart';

class CartButton extends StatelessWidget {
  const CartButton(
      {super.key,
      required this.onPressed,
      required this.number,
      this.colorIcon});
  final Function() onPressed;
  final String number;
  final Color? colorIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        child: badges.Badge(
          badgeStyle: badges.BadgeStyle(
              badgeColor: context.colorScheme.primaryContainer),
          position: badges.BadgePosition.topEnd(top: -1, end: -1),
          badgeContent: Text(number,
              style: context.labelSmall!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.labelSmall!.color)),
          child: Card(
            child: Container(
              padding: const EdgeInsets.all(defaultPadding / 1.3),
              width: 50,
              height: 50,
              child: SvgPicture.asset(
                AppAsset.shoppingCart,
                colorFilter: ColorFilter.mode(
                  colorIcon!,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
