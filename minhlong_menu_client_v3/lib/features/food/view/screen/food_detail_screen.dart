import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/cart_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_line_text.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/quantity_button.dart';
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

  @override
  void initState() {
    super.initState();
    _foodItem = widget.foodItem;
  }

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
    _indexImage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
                        child: CommonBackButton(onTap: () => context.pop()))),
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
                      number: '2',
                      colorIcon: AppColors.themeColor,
                    ),
                  ),
                )
              ],
            ),
            flexibleSpace:
                FlexibleSpaceBar(background: _buildFoodImage(_foodItem)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: _buildDetailsName(_foodItem))),
                    ],
                  ),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: FittedBox(
                              alignment: Alignment.centerLeft,
                              fit: BoxFit.scaleDown,
                              child: _buildDetailsPrice(_foodItem))),
                      5.horizontalSpace,
                      Expanded(
                          child: FittedBox(
                              alignment: Alignment.centerRight,
                              fit: BoxFit.scaleDown,
                              child: QuantityButton())),
                    ],
                  ),
                  20.verticalSpace,
                  _foodItem.description.isNotEmpty
                      ? _buildDetailsDescription(_foodItem)
                      : const SizedBox(),
                  10.verticalSpace,
                  _buildDetailsNote(),
                  20.verticalSpace,
                  Row(
                    children: [
                      Expanded(
                          child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: _buildDetailsButton())),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return CachedNetworkImage(
          imageUrl: '${ApiConfig.host}${images[index]}',
          fit: BoxFit.cover,
          errorWidget: errorBuilderForImage,
        );
      },
      options: CarouselOptions(
        onPageChanged: (index, reason) => _indexImage.value = index,
        reverse: false,
        enlargeCenterPage: true,
        autoPlay: true,
        aspectRatio: 1,
        autoPlayCurve: Curves.fastEaseInToSlowEaseOut,
        enableInfiniteScroll: true,
        autoPlayInterval: const Duration(seconds: 3),
        autoPlayAnimationDuration: const Duration(milliseconds: 1000),
        viewportFraction: 1,
      ),
      itemCount: images.length,
    );
  }

  Widget _buildDetailsName(FoodItem food) {
    return CommonLineText(
      title: food.name,
      titleStyle:
          kHeadingStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _buildDetailsPrice(FoodItem food) {
    return !food.isDiscount!
        ? Row(children: [
            Text(
                '₫ ${Ultils.currencyFormat(double.parse(food.price.toString()))}',
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                    fontSize: 24)),
          ])
        : Row(children: [
            Text(
                '₫ ${Ultils.currencyFormat(double.parse(food.price.toString()))}',
                style: kBodyStyle.copyWith(
                    color: AppColors.secondTextColor,
                    fontSize: 24,
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
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                    fontSize: 24)),
          ]);
  }

  Widget _buildDetailsDescription(FoodItem food) {
    return SizedBox(
      width: context.sizeDevice.width,
      height: context.isPortrait
          ? 0.2 * context.sizeDevice.height
          : 0.4 * context.sizeDevice.width,
      child: Text(
        food.description,
        style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
      ),
    );
  }

  Widget _buildDetailsNote() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(AppString.note,
            style: kHeadingStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 18)),
        CommonTextField(
          prefixIcon: const Icon(
            Icons.description_outlined,
            color: AppColors.secondTextColor,
          ),
          onChanged: (value) {},
          controller: _noteController,
          maxLines: 6,
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondTextColor)),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.secondTextColor)),
        ),
      ],
    );
  }

  Widget _buildDetailsButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.themeColor, // Button background color
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // Rounded corners
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2, vertical: defaultPadding - 4),
          ),
          onPressed: () {
            // Add your onPressed code here!
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(defaultPadding / 2),
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: AppColors.white),
                child: const Icon(
                  Icons.shopping_bag,
                  color: AppColors.themeColor,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                AppString.addToCart,
                style: const TextStyle(color: AppColors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
