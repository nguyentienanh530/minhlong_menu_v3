import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/Routes/app_route.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../core/app_colors.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';
import '../../core/utils.dart';
import '../../features/food/data/model/food_model.dart';

class CommonItemFood extends StatelessWidget {
  const CommonItemFood({super.key, required this.foodModel});
  final FoodModel foodModel;
  @override
  Widget build(BuildContext context) {
    return _buildFoodItem();
  }

  Widget _buildFoodItem() {
    return LayoutBuilder(builder: (context, constraints) {
      return InkWell(
        onTap: () => context.push(AppRoute.foodsDetails),
        child: AspectRatio(
          aspectRatio: 9 / 7,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(defaultBorderRadius),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      height: 0.7 * constraints.maxHeight,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(defaultBorderRadius),
                            topLeft: Radius.circular(defaultBorderRadius)),
                      ),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(defaultBorderRadius),
                            topLeft: Radius.circular(defaultBorderRadius)),
                        child: CachedNetworkImage(
                          imageUrl: foodModel.photoGallery[0],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    _buildNameFood(context, foodModel),
                    _buildPrice(context, foodModel),
                  ],
                ),
                foodModel.isDiscount
                    ? Positioned(
                        top: 0.62 * constraints.maxHeight,
                        right: 5,
                        child: _buildDiscountItem())
                    : const SizedBox(),
                Positioned(top: 5, right: 5, child: _addToCard()),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _addToCard() {
    return const Card(
      elevation: 4,
      shadowColor: AppColors.themeColor,
      shape: CircleBorder(),
      color: AppColors.red,
      child: SizedBox(
          height: 35,
          width: 35,
          child: Icon(
            Icons.add,
            color: AppColors.white,
            size: 30,
          )),
    );
  }

  Widget _buildDiscountItem() {
    return Card(
      color: AppColors.red,
      elevation: 4,
      shadowColor: AppColors.themeColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
      ),
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxWidth: 45, maxHeight: 25),
        child: Text(
          '${foodModel.discount}%',
          style: kBodyWhiteStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildNameFood(BuildContext context, FoodModel foodModel) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: FittedBox(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(
                right: defaultPadding,
                left: defaultPadding,
                top: defaultPadding / 3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(foodModel.name,
                    textAlign: TextAlign.left,
                    style: context.isTablet
                        ? kBodyStyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 18.0)
                        : kBodyStyle.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 14.0)),
                2.horizontalSpace,
                // const Icon(Icons.check_circle,
                //     color: AppColors.islamicGreen, size: 14),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrice(BuildContext context, FoodModel foodModel) {
    double discountAmount =
        (foodModel.price * foodModel.discount.toDouble()) / 100;
    double discountedPrice = foodModel.price - discountAmount;
    return !foodModel.isDiscount
        ? Expanded(
            child: SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Text(
                      '₫ ${Ultils.currencyFormat(double.parse(foodModel.price.toString()))}',
                      style: kBodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColors.themeColor)),
                ),
              ),
            ),
          )
        : Expanded(
            child: SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(children: [
                    Text(
                        '₫ ${Ultils.currencyFormat(double.parse(foodModel.price.toString()))}',
                        style: kBodyStyle.copyWith(
                            color: AppColors.secondTextColor,
                            fontSize: 12,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.solid)),
                    3.horizontalSpace,
                    Text(
                        '₫ ${Ultils.currencyFormat(double.parse(discountedPrice.toString()))}',
                        style: kBodyStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.themeColor,
                            fontSize: 12)),
                  ]),
                ),
              ),
            ),
          );
  }
}
