import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';

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
    return Card(
      child: Container(
        alignment: Alignment.center,
        width: 40,
        height: 40,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
          child: badges.Badge(
            badgeStyle:
                const badges.BadgeStyle(badgeColor: AppColors.islamicGreen),
            position: badges.BadgePosition.topEnd(top: -15, end: -15),
            badgeContent: Text(number,
                style: kBodyWhiteStyle.copyWith(
                    fontWeight: FontWeight.bold, fontSize: 10)),
            child: SvgPicture.asset(
              AppAsset.shoppingCart,
              width: 20,
              height: 20,
              color: colorIcon,
            ),
          ),
        ),
      ),
    );
  }
}
