part of '../screens/home_view.dart';

extension _NewsFoodWidget on _HomeViewState {
  Widget _buildListFoodView() {
    return BlocProvider(
      create: (context) =>
          FoodBloc(foodRepository: context.read<FoodRepository>())
            ..add(FoodFetched(property: 'created_at', limit: 10)),
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
              FoodFetchSuccess() => SizedBox(
                  width: context.sizeDevice.width,
                  height: sizeState.height,
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: foodState.food.foodItems.length,
                      itemBuilder: (context, index) {
                        return ItemFoodView(
                            food: foodState.food.foodItems[index],
                            height: sizeState.height ?? 0.0,
                            width: sizeState.width ?? 0.0);
                      }),
                ),
              _ => const SizedBox(),
            });
          }),
        ],
      ),
    );
  }
}
