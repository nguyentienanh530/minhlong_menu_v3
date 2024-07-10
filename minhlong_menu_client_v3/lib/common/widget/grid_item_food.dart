import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/features/food/view/screen/food_screen.dart';

import '../../core/app_const.dart';
import '../../features/food/data/model/food_model.dart';
import 'common_item_food.dart';

class GridItemFood extends StatelessWidget {
  final List<FoodModel>? list;
  final bool? isScroll;

  int crossCount;
  final aspectRatio;

  GridItemFood({
    super.key,
    required this.list,
    this.isScroll = false,
    required ModeScreen modeScreen,
    required this.crossCount,
    required this.aspectRatio,
  });

  Widget _buildGridItemFood(
      BuildContext contextt, List<FoodModel> food, crossCount, aspectRatio) {
    return GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        shrinkWrap: true,
        physics: isScroll!
            ? const BouncingScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: food.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: aspectRatio,
            mainAxisSpacing: defaultPadding / 2,
            crossAxisSpacing: defaultPadding / 2,
            crossAxisCount: crossCount),
        itemBuilder: (context, index) =>
            CommonItemFood(foodModel: food[index]));
  }

  @override
  Widget build(BuildContext context) {
    return _buildGridItemFood(context, list!, crossCount, aspectRatio);
  }
}
