part of '../screens/home_view.dart';

extension _PopularWidget on _HomeViewState {
  Widget _popularGridView(
      List<FoodItem> foods, OrderModel order, TableModel table) {
    return Column(
      children: [
        _buildTitle(
          AppString.popular,
          () => context.push(AppRoute.foods, extra: 'order_count'),
        ),
        GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: foods.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 9 / 11,
              mainAxisSpacing: defaultPadding / 2,
              crossAxisSpacing: defaultPadding / 2,
              crossAxisCount: 2),
          itemBuilder: (context, index) => CommonItemFood(
            addToCartOnTap: () =>
                _handleOnTapAddToCart(order, table, foods[index]),
            food: foods[index],
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
          Expanded(
            child: FittedBox(
              alignment: Alignment.centerLeft,
              fit: BoxFit.scaleDown,
              child: Text(title,
                  style: context.titleStyleMedium!
                      .copyWith(fontWeight: FontWeight.bold)),
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
                      style: context.labelMedium!.copyWith(
                          fontStyle: FontStyle.italic,
                          color: context.colorScheme.primary)),
                ),
                Icon(Icons.navigate_next_rounded,
                    size: 15, color: context.colorScheme.primary)
              ]))
        ]));
  }
}
