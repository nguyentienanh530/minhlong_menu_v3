import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/cart_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/cart/cubit/cart_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_item.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_detail.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';
import 'package:minhlong_menu_client_v3/features/table/cubit/table_cubit.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_string.dart';
import '../../../../core/utils.dart';

class FoodDetailScreen extends StatefulWidget {
  @override
  const FoodDetailScreen({super.key, required this.foodItem});

  final FoodItem foodItem;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final TextEditingController _noteController = TextEditingController();
  late final FoodItem _foodItem;
  final _indexImage = ValueNotifier(0);

  final _quantity = ValueNotifier(1);
  final _totalPrice = ValueNotifier<double>(0.0);
  double _priceFood = 0;

  @override
  void initState() {
    super.initState();
    _foodItem = widget.foodItem;

    _priceFood = Ultils.foodPrice(
        isDiscount: _foodItem.isDiscount ?? false,
        foodPrice: _foodItem.price ?? 0,
        discount: _foodItem.discount ?? 0);
    _totalPrice.value = _priceFood;
  }

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
    _indexImage.dispose();
    _quantity.dispose();
    _totalPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(builder: (context) {
        var cartState = context.watch<CartCubit>().state;
        var tableState = context.watch<TableCubit>().state;
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    centerTitle: true,
                    expandedHeight: 0.5 * context.sizeDevice.height,
                    backgroundColor: AppColors.white,
                    pinned: true,
                    stretch: true,
                    automaticallyImplyLeading: false,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: CommonBackButton(
                                    onTap: () => context.pop()))),
                        Expanded(
                          flex: 8,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: ValueListenableBuilder(
                              valueListenable: _indexImage,
                              builder: (context, value, child) {
                                return _buildIndicator(context, 4);
                              },
                            ),
                          ),
                        ),
                        Expanded(
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: CartButton(
                              onPressed: () => context.push(AppRoute.carts),
                              number: cartState.orderDetail.length.toString(),
                              colorIcon: AppColors.themeColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: _buildFoodImage(_foodItem),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          20.verticalSpace,
                          FittedBox(
                              fit: BoxFit.scaleDown,
                              child: _buildFoodDetailsName(_foodItem)),
                          20.verticalSpace,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.scaleDown,
                                      child:
                                          _buildFoodDetailsPrice(_foodItem))),
                              5.horizontalSpace,
                              Expanded(
                                  child: FittedBox(
                                      alignment: Alignment.centerRight,
                                      fit: BoxFit.scaleDown,
                                      child: _buildQuantity())),
                            ],
                          ),
                          10.verticalSpace,
                          _buildNoteWidget(),
                          20.verticalSpace,
                          _foodItem.description.isNotEmpty
                              ? _buildFoodDetailsDescription(_foodItem)
                              : const SizedBox(),
                          20.verticalSpace,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _buildAddToCartButton(cartState, tableState),
          ],
        );
      }),
    );
  }

  Widget _buildQuantity() {
    return ValueListenableBuilder(
        valueListenable: _quantity,
        builder: (context, quantity, child) => Center(
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(defaultBorderRadius * 3),
                ),
                child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildCounter(context,
                          icon: Icons.remove,
                          iconColor: AppColors.themeColor, onTap: () {
                        decrementQuaranty();
                      }),
                      Text(quantity.toString(),
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.black,
                              fontSize: 20)),
                      _buildCounter(context,
                          icon: Icons.add,
                          colorBg: AppColors.themeColor,
                          iconColor: AppColors.white, onTap: () {
                        incrementQuaranty();
                      })
                    ]),
              ),
            ));
  }

  void decrementQuaranty() {
    if (_quantity.value > 1) {
      _quantity.value--;
      _totalPrice.value = _quantity.value * _priceFood;
    }
  }

  void incrementQuaranty() {
    _quantity.value++;
    _totalPrice.value = _quantity.value * _priceFood;
  }

  Widget _buildCounter(BuildContext context,
      {IconData? icon, Color? colorBg, Color? iconColor, Function()? onTap}) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
                color: colorBg,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.themeColor)),
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: iconColor)));
  }

  Widget _buildIndicator(BuildContext context, int length) {
    return AnimatedSmoothIndicator(
        activeIndex: _indexImage.value,
        count: length,
        effect: const ExpandingDotsEffect(
            activeDotColor: AppColors.themeColor,
            dotHeight: 8,
            dotWidth: 8,
            dotColor: AppColors.white));
  }

  Widget _buildFoodImage(FoodItem food) {
    var images = [food.image1, food.image2, food.image3, food.image4];
    return Stack(
      fit: StackFit.expand,
      children: [
        CarouselSlider.builder(
          itemBuilder: (context, index, realIndex) {
            return CachedNetworkImage(
              imageUrl: images[index]!.isEmpty
                  ? ''
                  : '${ApiConfig.host}${images[index]}',
              fit: BoxFit.cover,
              errorWidget: errorBuilderForImage,
            );
          },
          options: CarouselOptions(
              onPageChanged: (index, reason) => _indexImage.value = index,
              reverse: false,
              enlargeCenterPage: true,
              autoPlay: false,
              aspectRatio: 1,
              autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
              enableInfiniteScroll: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 1000),
              viewportFraction: 1,
              clipBehavior: Clip.antiAlias),
          itemCount: images.length,
        ),
      ],
    );
  }

  Widget _buildFoodDetailsName(FoodItem food) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(Icons.check_circle, color: AppColors.islamicGreen, size: 24),
        5.horizontalSpace,
        Text(
          food.name,
          style:
              kHeadingStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ],
    );
  }

  Widget _buildFoodDetailsPrice(FoodItem food) {
    return !food.isDiscount!
        ? Row(children: [
            Text(
                '₫ ${Ultils.currencyFormat(double.parse(food.price.toString()))}',
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.themeColor)),
          ])
        : Row(children: [
            Text(
                '₫ ${Ultils.currencyFormat(double.parse(food.price.toString()))}',
                style: kBodyStyle.copyWith(
                    color: AppColors.secondTextColor,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 1,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.solid)),
            5.horizontalSpace,
            Text(
                Ultils.currencyFormat(Ultils.foodPrice(
                    isDiscount: food.isDiscount!,
                    foodPrice: food.price!,
                    discount: food.discount!)),
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.bold, color: AppColors.themeColor)),
          ]);
  }

  Widget _buildFoodDetailsDescription(FoodItem food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.description,
            style: kSubHeadingStyle.copyWith(fontWeight: FontWeight.w700)),
        10.verticalSpace,
        ReadMoreText(
          food.description,
          trimLines: 8,
          trimMode: TrimMode.Line,
          trimCollapsedText: AppString.seeMore,
          trimExpandedText: AppString.hide,
          style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          lessStyle: kBodyStyle.copyWith(color: AppColors.themeColor),
          moreStyle: kBodyStyle.copyWith(color: AppColors.themeColor),
        )
      ],
    );
  }

  Widget _buildNoteWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppString.note,
          style: kSubHeadingStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        10.verticalSpace,
        CommonTextField(
          prefixIcon: const Icon(
            Icons.description_outlined,
            color: AppColors.secondTextColor,
          ),
          onChanged: (value) {},
          controller: _noteController,
        ),
      ],
    );
  }

  Widget _buildAddToCartButton(OrderModel order, TableModel table) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FilledButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.themeColor, // Button background color
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30), // Rounded corners
              ),
            ),
            onPressed: () {
              _handleOnTapAddToCart(order, table);
            },
            icon: Container(
              margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
              padding: const EdgeInsets.all(defaultPadding / 2),
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: AppColors.white),
              child: const Icon(
                Icons.shopping_bag,
                color: AppColors.themeColor,
                size: 20,
              ),
            ),
            label: Text(
              AppString.addToCart,
              style: const TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }

  void _handleOnTapAddToCart(OrderModel order, TableModel table) async {
    if (table.name.isEmpty) {
      AppSnackbar.showSnackBar(context, msg: 'Chưa chọn bàn', isSuccess: false);
    } else {
      if (checkExistFood(order)) {
        AppSnackbar.showSnackBar(context,
            msg: 'Món ăn đã có trong giỏ hàng.', isSuccess: false);
      } else {
        var newFoodOrder = OrderDetail(
            foodID: _foodItem.id,
            foodImage: _foodItem.image1 ?? '',
            foodName: _foodItem.name,
            quantity: _quantity.value,
            totalPrice: _totalPrice.value,
            note: _noteController.text,
            discount: _foodItem.discount ?? 0,
            foodPrice: _foodItem.price ?? 0,
            isDiscount: _foodItem.isDiscount ?? false);
        var newFoods = [...order.orderDetail, newFoodOrder];
        double newTotalPrice = newFoods.fold(
            0, (double total, currentFood) => total + currentFood.totalPrice);
        order = order.copyWith(
            // tableName: table.name,
            // tableID: table.id,
            orderDetail: newFoods,
            // status: 'new',
            totalPrice: newTotalPrice);
        context.read<CartCubit>().setOrderModel(order);
        AppSnackbar.showSnackBar(context,
            msg: 'Món ăn đã được thêm.', isSuccess: true);
        _quantity.value = 1;
        _noteController.clear();
      }
    }
  }

  bool checkExistFood(OrderModel orderModel) {
    var isExist = false;
    for (OrderDetail e in orderModel.orderDetail) {
      if (e.foodID == _foodItem.id) {
        isExist = true;
        break;
      }
    }
    return isExist;
  }
}
