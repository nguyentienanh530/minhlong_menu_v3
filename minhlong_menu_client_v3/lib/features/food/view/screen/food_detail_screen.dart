import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/common/widget/cart_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_line_text.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../../../common/widget/quantity_button.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_string.dart';
import '../../../../core/utils.dart';
import '../../data/model/food_model.dart';

class FoodDetailScreen extends StatefulWidget {
  @override
  const FoodDetailScreen({super.key, required this.foodModel});

  final FoodModel foodModel;

  @override
  State<FoodDetailScreen> createState() => _FoodDetailScreenState();
}

class _FoodDetailScreenState extends State<FoodDetailScreen> {
  final TextEditingController _noteController = TextEditingController();
  late final FoodModel _foodModel;

  @override
  void initState() {
    super.initState();
    _foodModel = widget.foodModel;
  }

  @override
  void dispose() {
    super.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 0.5 * context.sizeDevice.height,
            backgroundColor: AppColors.white,
            pinned: true,
            stretch: true,
            actions: [
              CartButton(
                onPressed: () {},
                number: '2',
                colorIcon: AppColors.themeColor,
              )
            ],
            flexibleSpace:
                FlexibleSpaceBar(background: _buildFoodImage(_foodModel)),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  _buildDetailsName(),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailsPrice(),
                      5.horizontalSpace,
                      QuantityButton(),
                    ],
                  ),
                  20.verticalSpace,
                  _buildDetailsDescription(context),
                  10.verticalSpace,
                  _buildDetailsNote(),
                  20.verticalSpace,
                  _buildDetailsButton(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodImage(FoodModel food) {
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

  Widget _buildDetailsName() {
    return CommonLineText(
      title: _foodModel.name,
      titleStyle:
          kHeadingStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _buildDetailsPrice() {
    return !_foodModel.isDiscount
        ? Row(children: [
            Text(
                '₫${Ultils.currencyFormat(double.parse(_foodModel.price.toString()))}',
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                    fontSize: 24)),
          ])
        : Row(children: [
            Text(
                '₫${Ultils.currencyFormat(double.parse(_foodModel.price.toString()))}',
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
                    isDiscount: _foodModel.isDiscount,
                    foodPrice: _foodModel.price,
                    discount: _foodModel.discount)),
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                    fontSize: 24)),
          ]);
  }

  Widget _buildDetailsDescription(BuildContext context) {
    return SizedBox(
      width: context.sizeDevice.width,
      height: context.isPortrait
          ? 0.2 * context.sizeDevice.height
          : 0.4 * context.sizeDevice.width,
      child: Text(
        _foodModel.description,
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
                horizontal: defaultPadding, vertical: defaultPadding - 4),
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
