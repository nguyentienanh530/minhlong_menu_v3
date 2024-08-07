import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/core/app_asset.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/cart/cubit/cart_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_item.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';
import 'package:minhlong_menu_client_v3/features/table/cubit/table_cubit.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';
import 'package:readmore/readmore.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/cart_button.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_string.dart';
import '../../../../core/utils.dart';
import '../../../user/cubit/user_cubit.dart';

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
  final _imageHeight = ValueNotifier(0.0);
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
    _imageHeight.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cartState = context.watch<CartCubit>().state;
    var tableState = context.watch<TableCubit>().state;
    var user = context.watch<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: ValueListenableBuilder(
          valueListenable: _indexImage,
          builder: (context, value, child) {
            return _buildIndicator(context, 4);
          },
        ),
        actions: [
          CartButton(
            onPressed: () => context.push(AppRoute.carts, extra: user),
            number: cartState.order.orderDetail.length.toString(),
            colorIcon: context.colorScheme.primary,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListenableBuilder(
                listenable: _imageHeight,
                builder: (context, _) {
                  return SingleChildScrollView(
                    child: Stack(
                      children: [
                        _buildFoodImage(_foodItem),
                        Positioned(
                          top: _imageHeight.value - 100,
                          right: 10,
                          left: 10,
                          child: Card(
                            elevation: 10,
                            margin: const EdgeInsets.symmetric(
                                horizontal: defaultPadding),
                            child: FittedBox(
                              child: Container(
                                padding: const EdgeInsets.all(defaultPadding),
                                constraints: BoxConstraints(
                                    maxWidth: context.sizeDevice.width * 0.8),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    _buildFoodDetailsName(_foodItem),
                                    10.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        _buildCategoryName(_foodItem),
                                        _buildOrderCount(_foodItem),
                                      ],
                                    ),
                                    10.verticalSpace,
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                            child: FittedBox(
                                          child:
                                              _buildFoodDetailsPrice(_foodItem),
                                        )),
                                        10.horizontalSpace,
                                        _buildQuantity()
                                      ],
                                    ),
                                    10.verticalSpace,
                                    _buildNoteWidget(),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(defaultPadding),
                          child: Column(
                            children: [
                              SizedBox(
                                height: _imageHeight.value + 150,
                                width: context.sizeDevice.width,
                              ),
                              _buildFoodDetailsDescription(_foodItem),
                            ],
                          ),
                        ),
                        10.verticalSpace
                      ],
                    ),
                  );
                }),
          ),
          _buildAddToCartButton(cartState.order, tableState),
        ],
      ),
    );
  }

  Widget _buildFoodImage(FoodItem food) {
    var images = [food.image1, food.image2, food.image3, food.image4];
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return CachedNetworkImage(
          imageUrl:
              images[index]!.isEmpty ? '' : '${ApiConfig.host}${images[index]}',
          placeholder: (context, url) => const Loading(),
          imageBuilder: (context, imageProvider) =>
              LayoutBuilder(builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _imageHeight.value = constraints.maxHeight;
            });
            return Container(
              height: context.sizeDevice.height * 0.5,
              width: context.sizeDevice.width,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(defaultBorderRadius * 2),
                    bottomRight: Radius.circular(defaultBorderRadius * 2)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            );
          }),
          fit: BoxFit.cover,
          errorWidget: errorBuilderForImage,
        );
      },
      options: CarouselOptions(
          viewportFraction: 1,
          aspectRatio: 1,
          onPageChanged: (index, reason) => _indexImage.value = index),
      itemCount: images.length,
    );
  }

  Widget _buildQuantity() {
    return ValueListenableBuilder(
      valueListenable: _quantity,
      builder: (context, quantity, child) => Center(
        child: Container(
          height: 40,
          width: 100,
          padding: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color: context.colorScheme.primary,
            borderRadius: BorderRadius.circular(defaultBorderRadius * 3),
          ),
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCounter(context,
                    icon: Icons.remove, iconColor: Colors.white, onTap: () {
                  decrementQuaranty();
                }),
                Text(quantity.toString(),
                    style: context.bodyLarge!.copyWith(color: Colors.white)),
                _buildCounter(context,
                    icon: Icons.add,
                    colorBg: context.colorScheme.primary,
                    iconColor: Colors.white, onTap: () {
                  incrementQuaranty();
                })
              ]),
        ),
      ),
    );
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
    return InkWell(
        borderRadius: BorderRadius.circular(defaultBorderRadius * 3),
        onTap: onTap,
        child: Container(
            height: 30,
            width: 30,
            alignment: Alignment.center,
            child: Icon(icon, size: 18, color: iconColor)));
  }

  Widget _buildIndicator(BuildContext context, int length) {
    return AnimatedSmoothIndicator(
        activeIndex: _indexImage.value,
        count: length,
        effect: ExpandingDotsEffect(
            activeDotColor: context.colorScheme.primary,
            dotHeight: 8,
            dotWidth: 8,
            dotColor: context.colorScheme.inversePrimary));
  }

  Widget _buildFoodDetailsName(FoodItem food) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Icon(
          Icons.fastfood_outlined,
          color: Colors.green,
          size: 24,
        ),
        5.horizontalSpace,
        Expanded(
          child: Text(
            food.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style:
                context.titleStyleLarge!.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodDetailsPrice(FoodItem food) {
    return !food.isDiscount!
        ? Row(children: [
            Text(
                '${Ultils.currencyFormat(double.parse(food.price.toString()))} ₫',
                style: context.titleStyleLarge!
                    .copyWith(fontWeight: FontWeight.bold)),
          ])
        : Row(
            children: [
              Text(
                  '${Ultils.currencyFormat(double.parse(food.price.toString()))} ₫',
                  style: context.titleStyleLarge!.copyWith(
                      color: context.colorScheme.outline,
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 3,
                      decorationColor: Colors.red,
                      decorationStyle: TextDecorationStyle.solid)),
              10.horizontalSpace,
              Text(
                '${Ultils.currencyFormat(Ultils.foodPrice(isDiscount: food.isDiscount!, foodPrice: food.price!, discount: food.discount!))} ₫',
                style: context.titleStyleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
  }

  Widget _buildFoodDetailsDescription(FoodItem food) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.description,
            style: context.bodyLarge!.copyWith(fontWeight: FontWeight.bold)),
        10.verticalSpace,
        ReadMoreText(
          food.description,
          trimLines: 5,
          trimMode: TrimMode.Line,
          trimCollapsedText: AppString.seeMore,
          trimExpandedText: AppString.hide,
          style: context.bodyMedium!.copyWith(
            color: context.bodyMedium!.color!.withOpacity(0.5),
          ),
          lessStyle:
              context.bodyMedium!.copyWith(color: context.colorScheme.primary),
          moreStyle:
              context.bodyMedium!.copyWith(color: context.colorScheme.primary),
        )
      ],
    );
  }

  Widget _buildNoteWidget() {
    return CommonTextField(
      prefixIcon: Icon(
        Icons.description_outlined,
        color: context.colorScheme.primary.withOpacity(0.7),
      ),
      onChanged: (value) {},
      style: context.bodyMedium,
      labelText: AppString.noteToChef,
      controller: _noteController,
    );
  }

  Widget _buildAddToCartButton(OrderModel order, TableModel table) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.transparent,
        child: FilledButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor:
                context.colorScheme.primary, // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
          ),
          onPressed: () {
            // _handleOnTapAddToCart(order, table);
            context.read<CartCubit>().addToCart(
                table: table, food: _foodItem, quantity: _quantity.value);
          },
          icon: Container(
              margin: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
              padding: const EdgeInsets.all(defaultPadding / 2),
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: context.colorScheme.onPrimary),
              child: SvgPicture.asset(
                AppAsset.shoppingCart,
                height: 20,
                colorFilter: ColorFilter.mode(
                    context.colorScheme.primary, BlendMode.srcIn),
              )),
          label: Text(
            AppString.addToCart,
            style: context.bodyMedium!.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryName(FoodItem foodItem) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: 'Danh mục - ', style: context.bodySmall),
      TextSpan(text: foodItem.categoryName, style: context.bodyMedium)
    ]));
  }

  Widget _buildOrderCount(FoodItem foodItem) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: 'Lượt đặt : ', style: context.bodySmall),
      TextSpan(text: foodItem.orderCount.toString(), style: context.bodyMedium)
    ]));
  }
}
