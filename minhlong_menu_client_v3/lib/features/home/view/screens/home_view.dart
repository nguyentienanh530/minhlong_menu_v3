import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_client_v3/common/snackbar/app_snackbar.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_item_food.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/bloc/food_bloc.dart';
import 'package:minhlong_menu_client_v3/features/food/cubit/item_size_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/dto/item_food_size_dto.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import 'package:minhlong_menu_client_v3/features/user/data/model/user_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_screen.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';
import '../../../banner/data/model/banner_model.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../category/data/model/category_model.dart';
import '../../../food/data/model/food_item.dart';
import '../../../table/cubit/table_cubit.dart';
import '../../bloc/home_bloc.dart';

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

class _HomeViewState extends State<HomeView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final TextEditingController _searchText = TextEditingController();
  final _indexPage = ValueNotifier(0);

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeFetched());
  }

  @override
  void dispose() {
    super.dispose();
    _indexPage.dispose();
    _searchText.dispose();
  }

  void _onRefresh() {
    context.read<HomeBloc>().add(HomeFetched());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var cartState = context.watch<CartCubit>().state;
    var tableState = context.watch<TableCubit>().state;
    var user = context.watch<UserCubit>().state;

    return Scaffold(
      floatingActionButton: _buildFloatingButton(cartState.order, user),
      body: BlocListener<CartCubit, CartState>(
        listener: (context, state) {
          if (state is AddToCartSuccess) {
            AppSnackbar.showSnackBar(context,
                msg: state.message, type: AppSnackbarType.success);
          }
          if (state is AddToCartFailure) {
            AppDialog.showErrorDialog(context,
                description: "Ấn 'Chọn bàn' để đi đến chọn bàn",
                title: 'Chưa chọn bàn'.toUpperCase(),
                haveCancelButton: true,
                cancelText: 'Thoát',
                confirmText: 'Chọn bàn', onPressedComfirm: () {
              context.pop();
              context.push(AppRoute.dinnerTables);
            });
          }
          if (state is AddToCartExistFailure) {
            AppSnackbar.showSnackBar(context,
                msg: state.errorMessage, type: AppSnackbarType.error);
          }
        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            return (switch (state) {
              HomeFetchInProgress() => const Loading(),
              HomeFetchFailure() => ErrorScreen(errorMessage: state.message),
              HomeFetchSuccess() => RefreshIndicator(
                  onRefresh: () async => _onRefresh(),
                  child: CustomScrollView(
                    physics: const BouncingScrollPhysics(),
                    slivers: [
                      SliverAppBar(
                        stretch: true,
                        pinned: true,
                        titleSpacing: 10,
                        toolbarHeight: 80.h,
                        leadingWidth: 0,
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
                                            '${ApiConfig.host}${user.image}',
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
                                    style: context.bodySmall!.copyWith(
                                        color: context.bodySmall!.color!
                                            .withOpacity(0.5)),
                                  ),
                                  Text(user.fullName,
                                      style: context.bodyLarge!.copyWith(
                                          fontWeight: FontWeight.w900)),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  5.horizontalSpace,
                                  Expanded(child: _buildSearchWidget()),
                                  10.horizontalSpace,
                                  _buildIconTableWidget(tableState),
                                  5.horizontalSpace
                                ],
                              ),
                            )),
                        actions: [
                          _iconActionButtonAppBar(
                              icon: Icons.tune,
                              onPressed: () => context.push(AppRoute.profile)),
                          5.horizontalSpace
                        ],
                      ),
                      SliverToBoxAdapter(
                        child: AspectRatio(
                            aspectRatio: 16 / 9,
                            child: _bannerHome(state.homeModel.banners)),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            30.verticalSpace,
                            categoryListView(state.homeModel.categories),
                            10.verticalSpace,
                            _buildListNewFood(state.homeModel.newFoods,
                                cartState.order, tableState),
                            20.verticalSpace,
                            _popularGridView(state.homeModel.popularFoods,
                                cartState.order, tableState),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              _ => Container(),
            });
          },
        ),
      ),
    );
  }

  Widget _buildIconTableWidget(TableModel table) {
    return table.name.isEmpty
        ? _iconActionButtonAppBar(
            icon: Icons.table_restaurant,
            onPressed: () => context.push(AppRoute.dinnerTables),
          )
        : GestureDetector(
            onTap: () => context.push(AppRoute.dinnerTables),
            child: Card(
              color: context.colorScheme.primary,
              elevation: 4,
              child: Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(5),
                alignment: Alignment.center,
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(table.name,
                      textAlign: TextAlign.center,
                      style: context.bodyMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          );
  }

  Widget _buildFloatingButton(OrderModel orderModel, UserModel user) {
    return FloatingActionButton(
      backgroundColor: context.colorScheme.primary,
      onPressed: () => context.push(AppRoute.carts, extra: user),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding / 3),
        child: badges.Badge(
          badgeStyle: const badges.BadgeStyle(badgeColor: Colors.green),
          position: badges.BadgePosition.topEnd(top: -20, end: -20),
          badgeContent: Text(orderModel.orderDetail.length.toString(),
              style: context.bodyMedium!.copyWith(color: Colors.white)),
          child: SvgPicture.asset(
            AppAsset.shoppingCart,
            height: 30,
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
