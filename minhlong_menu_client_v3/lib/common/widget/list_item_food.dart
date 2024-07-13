import 'package:flutter/material.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_item.dart';
import 'common_item_food.dart';

class ListItemFood extends StatelessWidget {
  final List<FoodItem>? foods;

  const ListItemFood({super.key, required this.foods});

  @override
  Widget build(BuildContext context) {
    print('ListItemFood: ${foods!.length}');
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: foods!.length,
      itemBuilder: (context, index) => CommonItemFood(food: foods![index]),
    );
  }
}
