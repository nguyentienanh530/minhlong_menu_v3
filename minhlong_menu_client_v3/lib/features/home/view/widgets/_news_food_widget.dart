part of '../screens/home_view.dart';

extension _NewsFoodWidget on _HomeViewState {
  Widget _buildListFoodView(FoodModel foodModel) {
    return BlocProvider(
      create: (context) =>
          FoodBloc(foodRepository: context.read<FoodRepository>())
            ..add(FoodFetched(property: 'created_at', limit: 10)),
      child: Column(
        children: [
          _buildTitle(AppString.newFoods, () => context.push(AppRoute.foods)),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Builder(builder: (context) {
              var foodState = context.watch<FoodBloc>().state;
              return (switch (foodState) {
                FoodFetchInProgress() => const Loading(),
                FoodFetchEmpty() => const EmptyWidget(),
                FoodFetchFailure() => ErrWidget(error: foodState.message),
                FoodFetchSuccess() => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: foodState.foods.length,
                    itemBuilder: (context, index) {
                      return CommonItemFood(foodModel: foodState.foods[index]);
                    },
                  ),
                _ => const SizedBox(),
              });

              // ListView(
              //   scrollDirection: Axis.horizontal,
              //   children: List.generate(
              //     10,
              //     (index) => CommonItemFood(
              //       foodModel: foodModel,
              //     ),
              //   ),
              // );
            }),
          ),
        ],
      ),
    );
  }
}
