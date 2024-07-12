part of '../screens/home_view.dart';

extension _PopularWidget on _HomeViewState {
  Widget _popularGridView(FoodModel foodModel) {
    return Column(
      children: [
        _buildTitle(
          AppString.popular,
          () => context.push(AppRoute.foodsDetails),
        ),
        GridView(
          padding: const EdgeInsets.all(0),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          children: List.generate(
            8,
            (index) => CommonItemFood(
              foodModel: foodModel,
            ),
          ),
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
