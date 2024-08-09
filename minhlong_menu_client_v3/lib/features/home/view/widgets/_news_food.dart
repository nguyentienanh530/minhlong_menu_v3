part of '../screens/home_view.dart';

extension on _HomeViewState {
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
      height: 250,
      child: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.only(
            left: defaultPadding / 2, bottom: defaultPadding / 2),
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: foods.length,
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 9 / 11,
            child: CommonItemFood(
              addToCartOnTap: () {
                context
                    .read<CartCubit>()
                    .addToCart(table: table, food: foods[index]);
              },
              food: foods[index],
            ),
          );
        },
      ),
    );
  }
}
