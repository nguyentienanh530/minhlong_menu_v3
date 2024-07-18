part of '../screens/home_view.dart';

extension _PopularWidget on _HomeViewState {
  Widget _popularGridView() {
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
              FoodFetchSuccess() => GridItemFood(
                  crossAxisCount: 2,
                  foods: foodState.food.foodItems,
                  aspectRatio: 0.8,
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

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.themeColor,
      onPressed: () => context.push(AppRoute.carts),
      child: Builder(builder: (context) {
        var cartState = context.watch<CartCubit>().state;
        return Padding(
          padding: const EdgeInsets.all(5),
          child: badges.Badge(
            badgeStyle:
                const badges.BadgeStyle(badgeColor: AppColors.islamicGreen),
            position: badges.BadgePosition.topEnd(top: -14),
            badgeContent: Text(cartState.orderDetail.length.toString(),
                style: kBodyWhiteStyle),
            child: SvgPicture.asset(
              AppAsset.shoppingCart,
              height: double.infinity,
              fit: BoxFit.cover,
              colorFilter:
                  const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            ),
          ),
        );
      }),
    );
  }
}
