import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/common/widget/cart_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_line_text.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';

import '../../../../common/widget/quantity_button.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_string.dart';
import '../../../../core/utils.dart';
import '../../data/model/food_model.dart';

class FoodDetailsView extends StatelessWidget {
  @override
  FoodDetailsView({super.key});
  final FoodModel foodModel = FoodModel(
    id: 1,
    name: 'Bánh mì',
    categoryID: 1,
    isShow: true,
    isDiscount: true,
    discount: 10,
    price: 200000,
    photoGallery: [
      'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
      'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
      'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
    ],
    description:
        'Mỗi món ăn lại có cách chế biến, cách thưởng thức khác nhau. Với 17 bài thuyết minh cách làm món canh chua cá lóc, bún tôm Hải Phòng, bánh cuốn, nem chua, bánh trôi nước, bánh cốm, bún thang, vịt quay me, bánh ít lá gai, bánh xèo,... các em sẽ viết bài văn thuyết minh thật hay.',
    orderCount: 10,
    createAt: '2021-11-11 11:11:11',
  );
  final TextEditingController _noteController = TextEditingController();

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
            flexibleSpace: FlexibleSpaceBar(background: _buildDetailsImage()),
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

  Widget _buildDetailsImage() {
    return CarouselSlider.builder(
      itemBuilder: (context, index, realIndex) {
        return CachedNetworkImage(
          imageUrl: foodModel.photoGallery[index],
          fit: BoxFit.cover,
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
      itemCount: foodModel.photoGallery.length,
    );
  }

  Widget _buildDetailsName() {
    return CommonLineText(
      title: foodModel.name,
      titleStyle:
          kHeadingStyle.copyWith(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _buildDetailsPrice() {
    double discountAmount =
        (foodModel.price * foodModel.discount.toDouble()) / 100;
    double discountedPrice = foodModel.price - discountAmount;
    return !foodModel.isDiscount
        ? Row(children: [
            Text(
                '₫${Ultils.currencyFormat(double.parse(foodModel.price.toString()))}',
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.themeColor,
                    fontSize: 24)),
          ])
        : Row(children: [
            Text(
                '₫${Ultils.currencyFormat(double.parse(foodModel.price.toString()))}',
                style: kBodyStyle.copyWith(
                    color: AppColors.secondTextColor,
                    fontSize: 24,
                    decoration: TextDecoration.lineThrough,
                    decorationThickness: 1,
                    decorationColor: Colors.red,
                    decorationStyle: TextDecorationStyle.solid)),
            5.horizontalSpace,
            Text(
                Ultils.currencyFormat(double.parse(discountedPrice.toString())),
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
        foodModel.description,
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
