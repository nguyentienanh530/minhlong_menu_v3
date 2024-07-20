part of '../screens/home_view.dart';

extension _NewsFoodWidget on _HomeViewState {
  Widget _buildListNewFood(OrderModel orderModel, TableModel table) {
    return BlocProvider(
      create: (context) =>
          FoodBloc(foodRepository: context.read<FoodRepository>())
            ..add(FoodFetched(property: 'created_at', limit: 10, page: 1)),
      child: Column(
        children: [
          _buildTitle(AppString.newFoods,
              () => context.push(AppRoute.foods, extra: 'created_at')),
          Builder(builder: (context) {
            var foodState = context.watch<FoodBloc>().state;
            var sizeState = context.watch<ItemSizeCubit>().state;

            return (switch (foodState) {
              FoodFetchInProgress() => const Loading(),
              FoodFetchEmpty() => const EmptyWidget(),
              FoodFetchFailure() => ErrWidget(error: foodState.message),
              FoodFetchSuccess() => _buildSuccessWidget(
                  context, sizeState, foodState.food, orderModel, table),
              _ => const SizedBox(),
            });
          }),
        ],
      ),
    );
  }

  SizedBox _buildSuccessWidget(BuildContext context, ItemFoodSizeDTO sizeState,
      FoodModel food, OrderModel orderModel, TableModel table) {
    return SizedBox(
      width: context.sizeDevice.width,
      height: sizeState.height,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 8),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: food.foodItems.length,
          itemBuilder: (context, index) {
            return ItemFoodView(
              keyItem: _managerList.keys[index],
              addToCartOnTap: () {
                _handleOnTapAddToCart(orderModel, table, food.foodItems[index]);
                // calculatePathAndAnimate(index);
              },
              food: food.foodItems[index],
              height: sizeState.height ?? 0.0,
              width: sizeState.width ?? 0.0,
            );
          }),
    );
  }
}
