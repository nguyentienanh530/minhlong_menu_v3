import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_item_food.dart';
import 'package:minhlong_menu_client_v3/common/widget/empty_widget.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/core/utils.dart';
import 'package:minhlong_menu_client_v3/features/food/bloc/food_bloc.dart';
import 'package:minhlong_menu_client_v3/features/food/cubit/item_size_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';
import 'package:minhlong_menu_client_v3/features/user/bloc/user_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../banner/bloc/banner_bloc.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/model/category_model.dart';
import '../../../food/data/model/food_item.dart';
import '../../../order/data/model/order_detail.dart';
import '../../../table/cubit/table_cubit.dart';

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
  final TextEditingController _searchText = TextEditingController();
  final _indexPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(UserFetched());
  }

  @override
  void dispose() {
    super.dispose();
    _indexPage.dispose();
    _searchText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cartState = context.watch<CartCubit>().state;
    var tableState = context.watch<TableCubit>().state;
    var userState = context.watch<UserBloc>().state;
    return Scaffold(
      floatingActionButton: _buildFloatingButton(cartState),
      body: userState is UserFecthSuccess
          ? CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  stretch: true,
                  pinned: true,
                  titleSpacing: 10,
                  toolbarHeight: 80.h,
                  leadingWidth: 0,
                  backgroundColor: AppColors.lavender,
                  title: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Card(
                          elevation: 4,
                          shape: const CircleBorder(),
                          child: Container(
                            width: 40,
                            height: 40,
                            clipBehavior: Clip.antiAlias,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              child: CachedNetworkImage(
                                  imageUrl:
                                      '${ApiConfig.host}${userState.userModel.image}',
                                  placeholder: (context, url) =>
                                      const Loading(),
                                  errorWidget: errorBuilderForImage,
                                  fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        10.horizontalSpace,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin chào!',
                              style: kCaptionStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.secondTextColor,
                              ),
                            ),
                            Text(
                              userState.userModel.fullName,
                              style: kBodyStyle.copyWith(
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  bottom: PreferredSize(
                      preferredSize: const Size(double.infinity, 40),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: defaultPadding / 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            5.horizontalSpace,
                            Expanded(child: _buildSearchWidget()),
                            10.horizontalSpace,
                            _buildIconTableWidget(tableState),
                            5.horizontalSpace
                          ],
                        ),
                      )),
                  // flexibleSpace: FlexibleSpaceBar(
                  //   stretchModes: const <StretchMode>[
                  //     StretchMode.fadeTitle,
                  //   ],
                  //   background: _bannerHome(),
                  // ),
                  actions: [
                    _iconActionButtonAppBar(
                        icon: Icons.tune,
                        onPressed: () => context.push(AppRoute.profile)),
                    5.horizontalSpace
                  ],
                ),
                // const SliverToBoxAdapter(child: SizedBox(height: 10)),
                SliverToBoxAdapter(
                  child: AspectRatio(aspectRatio: 16 / 9, child: _bannerHome()),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      30.verticalSpace,
                      categoryListView(),
                      10.verticalSpace,
                      _buildListNewFood(cartState, tableState),
                      20.verticalSpace,
                      _popularGridView(cartState, tableState),
                      // Text("Scroll Offset: ${_scrollController.offset}"),
                    ],
                  ),
                ),
              ],
            )
          : const SizedBox(),
    );
  }

  _buildIconTableWidget(TableModel table) {
    return table.name.isEmpty
        ? _iconActionButtonAppBar(
            icon: Icons.table_restaurant,
            onPressed: () => context.push(AppRoute.dinnerTables),
          )
        : GestureDetector(
            onTap: () => context.push(AppRoute.dinnerTables),
            child: Card(
              color: AppColors.themeColor,
              elevation: 4,
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(table.name,
                      textAlign: TextAlign.center, style: kCaptionWhiteStyle),
                ),
              ),
            ),
          );
  }

  Widget _buildFloatingButton(OrderModel orderModel) {
    return FloatingActionButton(
      backgroundColor: AppColors.themeColor,
      onPressed: () => context.push(AppRoute.carts),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: badges.Badge(
          badgeStyle:
              const badges.BadgeStyle(badgeColor: AppColors.islamicGreen),
          position: badges.BadgePosition.topEnd(top: -14),
          badgeContent: Text(orderModel.orderDetail.length.toString(),
              style: kBodyWhiteStyle),
          child: SvgPicture.asset(
            AppAsset.shoppingCart,
            height: double.infinity,
            fit: BoxFit.cover,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  bool checkExistFood(OrderModel orderModel, int foodID) {
    var isExist = false;
    for (OrderDetail e in orderModel.orderDetail) {
      if (e.foodID == foodID) {
        isExist = true;
        break;
      }
    }
    return isExist;
  }

  void _handleOnTapAddToCart(
      OrderModel order, TableModel table, FoodItem food) async {
    if (table.name.isEmpty) {
      AppSnackbar.showSnackBar(context, msg: 'Chưa chọn bàn', isSuccess: false);
    } else {
      if (checkExistFood(order, food.id)) {
        AppSnackbar.showSnackBar(context,
            msg: 'Món ăn đã có trong giỏ hàng.', isSuccess: false);
      } else {
        var newFoodOrder = OrderDetail(
            foodID: food.id,
            foodImage: food.image1 ?? '',
            foodName: food.name,
            quantity: 1,
            totalPrice: Ultils.foodPrice(
                isDiscount: food.isDiscount ?? false,
                foodPrice: food.price ?? 0,
                discount: food.discount ?? 0),
            note: '',
            discount: food.discount ?? 0,
            foodPrice: food.price ?? 0,
            isDiscount: food.isDiscount ?? false);
        var newFoods = [...order.orderDetail, newFoodOrder];
        double newTotalPrice = newFoods.fold(
            0, (double total, currentFood) => total + currentFood.totalPrice);
        order =
            order.copyWith(orderDetail: newFoods, totalPrice: newTotalPrice);
        context.read<CartCubit>().setOrderModel(order);
        AppSnackbar.showSnackBar(context,
            msg: 'Món ăn đã được thêm.', isSuccess: true);
      }
    }
  }
}
