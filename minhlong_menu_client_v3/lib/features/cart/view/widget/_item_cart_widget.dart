part of '../screen/cart_screen.dart';

extension _ItemCartWidget on _CartViewState {
  Widget _itemCart(OrderModel orderModel, OrderDetail orderItem) {
    return Card(
      elevation: 4,
      child: Container(
        constraints: const BoxConstraints(minHeight: 100),
        padding: const EdgeInsets.all(
          defaultPadding / 2,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              SizedBox(
                height: 80,
                width: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
                  child: CachedNetworkImage(
                    imageUrl: '${ApiConfig.host}${orderItem.foodImage}',
                    placeholder: (context, url) => const Loading(),
                    errorWidget: errorBuilderForImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              orderItem.foodName,
                              style: kHeadingStyle.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: CommonIconButton(
                                onTap: () {
                                  context
                                      .read<CartCubit>()
                                      .removeOrderItem(orderItem);
                                },
                                icon: Icons.delete,
                                size: 25,
                                iconSize: 15,
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${Ultils.currencyFormat(Ultils.foodPrice(isDiscount: orderItem.isDiscount, foodPrice: orderItem.foodPrice, discount: orderItem.discount))} ₫',
                              style: kBodyStyle.copyWith(
                                color: AppColors.themeColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            _buildQuality(orderModel, orderItem),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
            orderItem.note.isNotEmpty
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Divider(
                        color: AppColors.secondTextColor,
                        thickness: 0.3,
                      ),
                      const Text(
                        "Ghi chú: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(orderItem.note, style: kCaptionStyle)
                    ],
                  )
                : const SizedBox()
          ]
              .animate()
              .slideX(
                  begin: -0.1,
                  end: 0,
                  curve: Curves.easeInOutCubic,
                  duration: 500.ms)
              .fadeIn(curve: Curves.easeInOutCubic, duration: 500.ms),
        ),
      ),
    );
  }

  Widget _buildQuality(OrderModel orderModel, OrderDetail foodOrder) {
    var quantity = ValueNotifier(foodOrder.quantity);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // LineText(title: "Số lượng: ", value: food.quantity.toString()),
        InkWell(
          onTap: () {
            if (quantity.value > 1) {
              quantity.value--;
              _handleUpdateFood(orderModel, quantity.value, foodOrder);
            }
          },
          child: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.themeColor),
            child: const Icon(
              Icons.remove,
              size: 15,
              color: AppColors.white,
            ),
          ),
        ),
        ValueListenableBuilder(
          valueListenable: quantity,
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              value.toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            quantity.value++;
            _handleUpdateFood(orderModel, quantity.value, foodOrder);
          },
          child: Container(
            height: 20,
            width: 20,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.themeColor),
            child: const Icon(
              Icons.add,
              size: 15,
              color: AppColors.white,
            ),
          ),
        ),
      ],
    );
  }

  void _handleUpdateFood(
      OrderModel orderModel, int quantity, OrderDetail foodOrder) {
    int index = orderModel.orderDetail
        .indexWhere((element) => element.foodID == foodOrder.foodID);

    if (index != -1) {
      var existingFoodOrder = orderModel.orderDetail[index];
      var updatedFoodOrder = existingFoodOrder.copyWith(
          quantity: quantity,
          totalPrice: quantity *
              AppRes.foodPrice(
                  isDiscount: existingFoodOrder.isDiscount,
                  foodPrice: existingFoodOrder.foodPrice,
                  discount: int.parse(existingFoodOrder.discount.toString())));

      List<OrderDetail> updatedFoods = List.from(orderModel.orderDetail);
      updatedFoods[index] = updatedFoodOrder;
      double newTotalPrice = updatedFoods.fold(
          0, (double total, currentFood) => total + currentFood.totalPrice);
      orderModel = orderModel.copyWith(
          orderDetail: updatedFoods, totalPrice: newTotalPrice);
      context.read<CartCubit>().setOrderModel(orderModel);
    } else {
      return;
    }
  }
}
