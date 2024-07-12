part of '../screen/cart_screen.dart';

extension CartWidget on _CartScreenState {
  Widget _cartItem() {
    return Container(
      padding: const EdgeInsets.symmetric(
          horizontal: defaultPadding, vertical: defaultPadding * 2),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(defaultPadding),
            child: CachedNetworkImage(
              imageUrl: _foodList[0].photoGallery[0],
              placeholder: (context, url) => const Loading(),
              errorWidget: errorBuilderForImage,
            ),
          ),
        ),
        Expanded(
            flex: 3,
            child: Column(children: [
              Text(
                _foodList[0].name,
                style: kHeadingStyle,
              ),
              Text(
                '${Ultils.currencyFormat(double.parse(_foodList[0].price.toString()))} ₫',
              )
            ])),
        Expanded(flex: 3, child: QuantityButton()),
        Expanded(
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.close),
          ),
        )
      ]),
    );
  }
}
