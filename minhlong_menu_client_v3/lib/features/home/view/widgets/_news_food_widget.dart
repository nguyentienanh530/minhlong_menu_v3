part of '../screens/home_view.dart';

extension _NewsFoodWidget on _HomeViewState {
  Widget _buildListNewFood(
      List<FoodItem> foods, OrderModel orderModel, TableModel table) {
    var sizeState = context.watch<ItemSizeCubit>().state;
    return BlocProvider(
      create: (context) =>
          FoodBloc(foodRepository: context.read<FoodRepository>())
            ..add(FoodFetched(property: 'created_at', limit: 10, page: 1)),
      child: Column(
        children: [
          _buildTitle(AppString.newFoods,
              () => context.push(AppRoute.foods, extra: 'created_at')),
          _buildSuccessWidget(context, sizeState, foods, orderModel, table),
        ],
      ),
    );
  }

  SizedBox _buildSuccessWidget(BuildContext context, ItemFoodSizeDTO sizeState,
      List<FoodItem> foods, OrderModel orderModel, TableModel table) {
    return SizedBox(
      width: context.sizeDevice.width,
      height: sizeState.height,
      child: ListView.builder(
          padding: const EdgeInsets.only(left: 8),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: foods.length,
          itemBuilder: (context, index) {
            return ItemFoodView(
              keyItem: _managerList.keys[index],
              addToCartOnTap: () {
                _handleOnTapAddToCart(orderModel, table, foods[index]);
                // calculatePathAndAnimate(index);
              },
              food: foods[index],
              height: sizeState.height ?? 0.0,
              width: sizeState.width ?? 0.0,
            );
          }),
    );
  }
}
