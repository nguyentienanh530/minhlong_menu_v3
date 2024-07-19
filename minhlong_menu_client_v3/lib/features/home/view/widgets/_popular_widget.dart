part of '../screens/home_view.dart';

extension _PopularWidget on _HomeViewState {
  Widget _popularGridView(OrderModel order, TableModel table) {
    return Column(
      children: [
        _buildTitle(
          AppString.popular,
          () => context.push(AppRoute.foods, extra: 'order_count'),
        ),
        BlocProvider(
          create: (context) => FoodBloc(
            foodRepository: context.read<FoodRepository>(),
          )..add(
              FoodFetched(property: 'order_count', limit: 10, page: 1),
            ),
          child: Builder(builder: (context) {
            final foodState = context.watch<FoodBloc>().state;
            return (switch (foodState) {
              FoodFetchInProgress() => const Loading(),
              FoodFetchEmpty() => const EmptyWidget(),
              FoodFetchFailure() => ErrWidget(error: foodState.message),
              FoodFetchSuccess() => GridView.builder(
                  padding: const EdgeInsets.symmetric(
                      horizontal: defaultPadding / 2),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: foodState.food.foodItems.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 9 / 11,
                      mainAxisSpacing: defaultPadding / 2,
                      crossAxisSpacing: defaultPadding / 2,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) => CommonItemFood(
                    addToCartOnTap: () => _handleOnTapAddToCart(
                        order, table, foodState.food.foodItems[index]),
                    food: foodState.food.foodItems[index],
                  ),
                ),
              _ => const SizedBox(),
            });
          }),
        ),
      ],
    );
  }

  Widget _buildTitle(String title, Function()? onTap) {
    return Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Expanded(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(title,
                  style: kHeadingStyle.copyWith(fontWeight: FontWeight.bold)),
            ),
          ),
          InkWell(
              onTap: onTap,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                FittedBox(
                  alignment: Alignment.centerRight,
                  fit: BoxFit.scaleDown,
                  child: Text(AppString.seeMore,
                      style: kBodyStyle.copyWith(
                          fontStyle: FontStyle.italic,
                          color: AppColors.themeColor)),
                ),
                const Icon(Icons.navigate_next_rounded,
                    size: 15, color: Colors.red)
              ]))
        ]));
  }
}
