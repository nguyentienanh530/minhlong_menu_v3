import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/core/api_config.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/data/dto/item_food_size_dto.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_item.dart';

import '../../Routes/app_route.dart';
import '../../core/app_colors.dart';
import '../../core/app_const.dart';
import '../../core/app_style.dart';
import '../../core/utils.dart';
import '../../features/food/cubit/item_size_cubit.dart';

class CommonItemFood extends StatelessWidget {
  const CommonItemFood({super.key, required this.food, this.addToCartOnTap});
  final FoodItem food;
  final void Function()? addToCartOnTap;

  @override
  Widget build(BuildContext context) {
    return _buildFoodItem(food);
  }

  Widget _buildFoodItem(FoodItem food) {
    return LayoutBuilder(builder: (context, constraints) {
      context.read<ItemSizeCubit>().setSize(ItemFoodSizeDTO(
          height: constraints.maxHeight, width: constraints.maxWidth));
      return ItemFoodView(
          addToCartOnTap: addToCartOnTap,
          food: food,
          height: constraints.maxHeight,
          width: constraints.maxWidth);
    });
  }
}

class ItemFoodView extends StatelessWidget {
  const ItemFoodView(
      {super.key,
      required this.food,
      required this.height,
      required this.width,
      this.addToCartOnTap,
      this.keyItem});
  final FoodItem food;
  final double height;
  final double width;
  final void Function()? addToCartOnTap;
  final GlobalKey? keyItem;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
      ),
      child: GestureDetector(
        onTap: () => context.push(AppRoute.foodsDetail, extra: food),
        child: SizedBox(
          key: keyItem,
          height: height,
          width: width,
          child: Stack(children: [
            Column(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  height: 0.7 * height,
                  width: width,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(defaultBorderRadius / 2),
                        topLeft: Radius.circular(defaultBorderRadius / 2)),
                  ),
                  child: CachedNetworkImage(
                    imageUrl: '${ApiConfig.host}${food.image1}',
                    fit: BoxFit.cover,
                    errorWidget: errorBuilderForImage,
                  ),
                ),
                _buildNameFood(context, food),
                _buildPrice(context, food),
              ],
            ),
            Positioned(top: 5, right: 5, child: _addToCard()),
            if (food.isDiscount!)
              Positioned(
                  right: 5,
                  top: 0.7 * height - 18,
                  child: _buildDiscountItem(food)),
          ]),
        ),
      ),
    );
  }

  Widget _addToCard() {
    return InkWell(
      onTap: addToCartOnTap,
      child: const Card(
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
      ),
    );
  }

  Widget _buildDiscountItem(FoodItem food) {
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
          '${food.discount}%',
          style: kBodyWhiteStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildNameFood(BuildContext context, food) {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
            ),
            child: Row(
              children: [
                const Icon(Icons.check_circle,
                    color: AppColors.islamicGreen, size: 16),
                5.horizontalSpace,
                Text(food.name,
                    textAlign: TextAlign.center,
                    style: context.isTablet
                        ? kHeadingStyle.copyWith(fontWeight: FontWeight.bold)
                        : kHeadingStyle.copyWith(fontWeight: FontWeight.bold)),
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

  Widget _buildPrice(BuildContext context, FoodItem food) {
    double discountAmount = (food.price! * food.discount!.toDouble()) / 100;
    double discountedPrice = food.price! - discountAmount;
    return !food.isDiscount!
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
                      '₫ ${Ultils.currencyFormat(double.parse(food.price.toString()))}',
                      style: kBodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
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
                        '₫ ${Ultils.currencyFormat(double.parse(food.price.toString()))}',
                        style: kBodyStyle.copyWith(
                            color: AppColors.secondTextColor,
                            decoration: TextDecoration.lineThrough,
                            fontSize: 18,
                            decorationThickness: 1,
                            decorationColor: Colors.red,
                            decorationStyle: TextDecorationStyle.solid)),
                    3.horizontalSpace,
                    Text(
                        '₫ ${Ultils.currencyFormat(double.parse(discountedPrice.toString()))}',
                        style: kBodyStyle.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.themeColor,
                        )),
                  ]),
                ),
              ),
            ),
          );
  }
}
