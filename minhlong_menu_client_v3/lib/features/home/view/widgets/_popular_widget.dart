part of '../screens/home_view.dart';

extension _PopularWidget on _HomeViewState {
  Widget _popularGridView(FoodModel foodModel) {
    return Column(
      children: [
        _buildTitle(
          AppString.popular,
          () {
            // context.push(AppRoute.foodsDetails)
          },
        ),
        BlocProvider(
          create: (context) => FoodBloc(
            foodRepository: context.read<FoodRepository>(),
          )..add(
              FoodFetched(property: 'order_count', limit: 10),
            ),
          child: Builder(builder: (context) {
            final foodState = context.watch<FoodBloc>().state;
            return (switch (foodState) {
              FoodFetchInProgress() => const Loading(),
              FoodFetchEmpty() => const EmptyWidget(),
              FoodFetchFailure() => ErrWidget(error: foodState.message),
              FoodFetchSuccess() => GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: foodState.foods.length,
                  itemBuilder: (context, index) {
                    return CommonItemFood(foodModel: foodState.foods[index]);
                  },
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
          Text(title,
              style: kHeadingStyle.copyWith(fontWeight: FontWeight.bold)),
          GestureDetector(
              onTap: onTap,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text(AppString.seeMore,
                    style: kBodyStyle.copyWith(
                        fontStyle: FontStyle.italic,
                        color: AppColors.themeColor)),
                const Icon(Icons.navigate_next_rounded,
                    size: 15, color: Colors.red)
              ]))
        ]));
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton(
      backgroundColor: AppColors.themeColor,
      onPressed: () => context.push(AppRoute.carts),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: badges.Badge(
          badgeStyle:
              const badges.BadgeStyle(badgeColor: AppColors.islamicGreen),
          position: badges.BadgePosition.topEnd(top: -14),
          badgeContent: const Text('2', style: kBodyWhiteStyle),
          child: SvgPicture.asset(
            AppAsset.shoppingCart,
            height: double.infinity,
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }
}
