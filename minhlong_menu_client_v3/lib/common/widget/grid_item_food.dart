import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_item.dart';
import '../../core/app_const.dart';
import 'common_item_food.dart';

class GridItemFood extends StatelessWidget {
  final List<FoodItem>? foods;
  final bool? isScroll;
  final double aspectRatio;
  final int crossAxisCount;
  final Axis? scrollDirection;

  const GridItemFood({
    super.key,
    required this.foods,
    this.isScroll = false,
    required this.aspectRatio,
    required this.crossAxisCount,
    this.scrollDirection,
  });

  Widget _buildGridItemFood(
      BuildContext contextt, List<FoodItem> foods, double aspectRatio) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        shrinkWrap: true,
        physics: isScroll!
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        scrollDirection: scrollDirection ?? Axis.vertical,
        itemCount: foods.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: aspectRatio,
            mainAxisSpacing: defaultPadding / 2,
            crossAxisSpacing: defaultPadding / 2,
            crossAxisCount: crossAxisCount),
        itemBuilder: (context, index) => CommonItemFood(food: foods[index]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridItemFood(context, foods ?? <FoodItem>[], aspectRatio);
  }
}
