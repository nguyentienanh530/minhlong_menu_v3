part of '../screens/home_view.dart';

extension _NewsFoodWidget on _HomeViewState {
  Widget _buildListFoodView(FoodModel foodModel) {
    return Column(
      children: [
        _buildTitle(AppString.newFoods, () => context.push(AppRoute.foods)),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: ListView(
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: List.generate(
              10,
              (index) => CommonItemFood(
                foodModel: foodModel,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
