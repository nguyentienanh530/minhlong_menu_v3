import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_asset.dart';
import '../../core/app_colors.dart';
import '../../core/app_style.dart';

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
    return IconButton(
      onPressed: onPressed,
      icon: badges.Badge(
        badgeStyle: const badges.BadgeStyle(badgeColor: AppColors.islamicGreen),
        position: badges.BadgePosition.topEnd(top: -5, end: -5),
        badgeContent: Text(number,
            style: kBodyWhiteStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 10)),
        child: SvgPicture.asset(
          AppAsset.shoppingCart,
          width: 50,
          height: 50,
          color: colorIcon,
        ),
      ),
    );
  }
}
