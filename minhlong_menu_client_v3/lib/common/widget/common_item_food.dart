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
import '../../core/app_const.dart';
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
      elevation: 5,
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
            Positioned(top: 5, right: 5, child: _addToCard(context)),
            if (food.isDiscount!)
              Positioned(
                  right: 5,
                  top: 0.7 * height - 18,
                  child: _buildDiscountItem(food, context)),
          ]),
        ),
      ),
    );
  }

  Widget _addToCard(BuildContext context) {
    return InkWell(
      onTap: addToCartOnTap,
      child: Card(
        elevation: 4,
        shape: const CircleBorder(),
        color: context.colorScheme.secondary,
        child: SizedBox(
            height: 35,
            width: 35,
            child: Icon(
              Icons.add,
              color: context.colorScheme.onPrimary,
              size: 30,
            )),
      ),
    );
  }

  Widget _buildDiscountItem(FoodItem food, BuildContext context) {
    return Card(
      color: Colors.red,
      elevation: 4,
      shadowColor: context.colorScheme.tertiaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(defaultBorderRadius)),
      ),
      child: Container(
        alignment: Alignment.center,
        constraints: const BoxConstraints(maxWidth: 45, maxHeight: 25),
        child: Text(
          '${food.discount}%',
          style: context.labelMedium!
              .copyWith(fontWeight: FontWeight.bold, color: Colors.white),
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
                Icon(Icons.check_circle,
                    color: context.colorScheme.primaryContainer, size: 16),
                5.horizontalSpace,
                Text(food.name,
                    textAlign: TextAlign.center,
                    style: context.titleStyleMedium!
                        .copyWith(fontWeight: FontWeight.bold)),
                2.horizontalSpace,
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
                      '${Ultils.currencyFormat(double.parse(food.price.toString()))} ₫',
                      style: context.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.secondary)),
                ),
              ),
            ),
          )
        : Expanded(
            child: Row(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  child: Row(children: [
                    Text(
                        '${Ultils.currencyFormat(double.parse(food.price.toString()))} ₫',
                        style: context.labelLarge!.copyWith(
                            color: context.colorScheme.outline,
                            decoration: TextDecoration.lineThrough,
                            decorationThickness: 1,
                            decorationColor: context.colorScheme.secondary,
                            decorationStyle: TextDecorationStyle.solid)),
                    3.horizontalSpace,
                    Text(
                        '${Ultils.currencyFormat(double.parse(discountedPrice.toString()))} ₫',
                        style: context.labelLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.secondary,
                        )),
                  ]),
                ),
              ],
            ),
          );
  }
}
