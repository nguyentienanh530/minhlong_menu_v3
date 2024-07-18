part of '../screen/cart_screen.dart';

extension CartWidget on _CartScreenState {
  Widget _cartItem() {
    return Card(
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding / 2, vertical: defaultPadding / 2),
        child: Row(children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
              child: CachedNetworkImage(
                imageUrl: _foodList[0].image1!,
                placeholder: (context, url) => const Loading(),
                errorWidget: errorBuilderForImage,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(children: [
                Text(
                  _foodList[0].name,
                  style: kHeadingStyle,
                ),
                Text(
                  '${Ultils.currencyFormat(double.parse(_foodList[0].price.toString()))} ₫',
                  style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
                )
              ]),
            ),
          ),
          Expanded(
            flex: 3,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: QuantityButton(),
            ),
          ),
          Expanded(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
            ),
          )
        ]),
      ),
    );
  }
}
