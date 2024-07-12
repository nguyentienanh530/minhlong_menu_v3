import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_item_food.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_text_field.dart';
import 'package:minhlong_menu_client_v3/common/widget/empty_widget.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_widget.dart';
// import 'package:minhlong_menu_client_v3/common/widget/no_product.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/bloc/food_bloc.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_model.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/error_build_image.dart';
// import '../../../../common/widget/error_dialog.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../auth/bloc/auth_bloc.dart';
import '../../../banner/bloc/banner_bloc.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/model/category_model.dart';

part '../widgets/_appbar_widget.dart';
part '../widgets/_banner_widget.dart';
part '../widgets/_category_widget.dart';
part '../widgets/_news_food_widget.dart';
part '../widgets/_popular_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final FoodModel _foodModel = FoodModel(
    id: 1,
    name: 'Bánh mì',
    categoryID: 1,
    isShow: true,
    isDiscount: false,
    discount: 10,
    price: 200000,
    image1:
        'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
    image2:
        'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
    image3:
        'https://lh3.googleusercontent.com/fife/ALs6j_Hr1Z_2KLUE5wgbI2RLKlaKbDg4X0m7QRyIpp-3XQjxO-4yU2F_hv69WHupSSWIS5Ng8HmPVriOaRCnpt5xlDjaLsk0RqByHVTQWUD_9qkAXOBVWtsZHugFtCIgORqDfH7qVftTMG86wzKAfD6Nx8bTRL5vE1YxVCjFv7es6cbJX2xk1TAfHGum6Ce1Bxk-vCpLlUjwWAcRI3BvnQ6vPMRxzJ3-5r21UtVRlpI_Sugz8Sqv0DoArv7zkCHgLx2431yCl4Mx_UYYNSJ0ANKpjJ4CtstX46-yAwBpU_gYoJjyQkXs6PGWURoPE6wWpnEM4CNmlYt6XvAFv14pdmP5P2F8Sld6K0FDvmlPSkV2IifSuvE2a1jru8MsJX3t8XdKWgpqCOcAxxJpkqcEAe1SSjDKp35GjPYFXkJojdMt15MG1KA4LJKHjD9yZWZIw8uIAm1akHnixP5Atn9nFnIjwP-O-VXyeCZ7u7zU_Z4USvcN_ylWqH1GsyHJ7278gqDnBT6mvWXfOu8UBJ_8j66jVA2xHR8soZUtObem6inv384hgGH1tr1q67Fn6VdNiduKmUyIX9b2kwEOGexWVeoGduZR1UnbzsQ5Hi8cmvj9OxCyPncru1W-IKofWux-yw5XGxYKv3_lOMvLFv38QvvFU4jBaCog5DKswtLbgNAK2Id9a5R6sVoTR8rVkbSl89tFBiHa_wv5lKBHws6PhglbR7fO_xjLeEGB2th1dg8aTfez58YJAAobOygwNmnulgj9S_U6wjpVr9xjyHbxgmE3jQpsfeSPxzMV9EEyNs_VMdFBSfwl3UcWM3kJqw2u1AOn9UiJeddzMlJNZv1wasrnVF8I9ZZuwq3vwYkou9piVsUTQkQOE6dXWwwCxYKj4SIxrJUt8Nl7qIPeaQ-5Fr2-NFchHcUWdfiHKai7jy1qRVewLVXsDCl92csVk_N-MgL3bfhlp2jDOpF_pyCi4gljoqyXfIMYFXokgB6-4Hh4mvHTJnRd3DV02AmhMsbgz_6NkiwyucMq2ZmXO_8rXdgjvNNp6FbkLoFg0jVWkBDF6syEUS7W1-gjIBmVc5tb7Vv_V49kzN-39ro0PUSp-YDU73XXP9CEnS2F56LjTI3XiPB1plG-ogupNJvmBUNIi4CTAF_soeLS16OddISL6Pw7AdexbhExXyt1FSYWNLURHw6aVZ-holV5RXYnCdjxrRIj2HUa4vsiO4DJjq5PSMU_X85iDGUcBEm681A_KpGVJJlmJvrFFsBL-pu1r1HKIl1EF1s2MGZhuXVuxxw6v2tRUoRu8yLtqWiBmuRYXv4vVq2-cPGhPYK9kHszYdeyRj6nuGjQtUyiS9QZLPKdJNMRzwTZaZdmPyR7bQmcBDJZnl8HdPSBqTckdaZNRPQA2dDjvF_gqdLoCOXFH9H_vT7qrmD_OlOUD6xHFk7JsB_cgJuw11J_wXlmu_EgbYhZeAqfPSWEP1KgveemZNm0XgcwsInbk454yE3dvgZiv-hIpeTNVyl1mjfFuEOn5OzVTd2k_3VfGyG-2KCsbaLDe5xFabxCg7ggzNGYH8lSNTqUrGxjUmK8YbGYfyOmWwAgRnL4rS8S1SDXDYTcSbUaUb7vaE-wCRvhE7bBE8JiEBm1nDQ62_Vsg0g2NQz8=w884-h705',
    description: '123123',
    orderCount: 10,
    createAt: '2021-11-11 11:11:11',
  );
  final TextEditingController _searchText = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _buildFloatingButton(),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            // toolbarHeight: 0.14 * context.sizeDevice.height,
            forceElevated: true,
            // primary: false,
            // forceMaterialTransparency: true,
            expandedHeight: context.isPortrait == true
                ? 0.25 * context.sizeDevice.height
                : 0.3 * context.sizeDevice.height,
            stretch: true,

            pinned: true,
            // pinned: context.isPortrait ? true : false,
            backgroundColor: AppColors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: _bannerHome(),
            ),
            title: _seachBox(),
            actions: [_tableButton(), _userProfile(), 5.horizontalSpace],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                // _bannerHome(),
                30.verticalSpace,
                categoryListView(),
                10.verticalSpace,
                _buildListFoodView(_foodModel),
                20.verticalSpace,
                _popularGridView(_foodModel),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showDialogLogout() {
    showDialog(
        context: context,
        builder: (context) {
          return AppDialog(
            title: 'Đăng xuất?',
            description: 'Bạn có muốn đăng xuất?',
            onTap: () {
              context.read<AuthBloc>().add(AuthLogoutStarted());
            },
          );
        });
  }
}
