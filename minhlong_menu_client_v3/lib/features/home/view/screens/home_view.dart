import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/animations/add_to_card_animation_manager.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_item_food.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/core/utils.dart';
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
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_screen.dart';
import '../../../../common/widget/loading.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_asset.dart';

import '../../../banner/data/model/banner_model.dart';
import '../../../cart/cubit/cart_cubit.dart';

import '../../../category/data/model/category_model.dart';
import '../../../food/data/model/food_item.dart';
import '../../../order/data/model/order_detail.dart';
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
  late AddToCardAnimationManager _managerList;
  final _foodItemSize = ValueNotifier(const Size(0, 0));
  late AnimationController _animationController;
  final _cartKey = GlobalKey();
  var _foodPosition = Offset.zero;
  var _path = Path();

  var cartPosition = Offset.zero;

  var cartBottomRight = Offset.zero;

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(HomeFetched());
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _managerList = AddToCardAnimationManager(lenght: 10);
  }

  @override
  void dispose() {
    super.dispose();
    _indexPage.dispose();
    _searchText.dispose();
    _foodItemSize.dispose();
    _animationController.dispose();
    _cartKey.currentState?.dispose();
  }

  void _resetAnimation() {
    _foodItemSize.value = const Size(0, 0);
    _foodPosition = Offset.zero;
    _path = Path();

    _cartKey.currentState?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    var cartState = context.watch<CartCubit>().state;
    var tableState = context.watch<TableCubit>().state;
    var user = context.watch<UserCubit>().state;

    return Scaffold(
      floatingActionButton: _buildFloatingButton(cartState, user),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return (switch (state) {
            HomeFetchInProgress() => const Loading(),
            HomeFetchFailure() => ErrorScreen(errorMessage: state.message),
            HomeFetchSuccess() => CustomScrollView(
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
                                    imageUrl: '${ApiConfig.host}${user.image}',
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
                                user.fullName,
                                style: kBodyStyle.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
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
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            30.verticalSpace,
                            categoryListView(state.homeModel.categories),
                            10.verticalSpace,
                            _buildListNewFood(state.homeModel.newFoods,
                                cartState, tableState),
                            20.verticalSpace,
                            _popularGridView(state.homeModel.popularFoods,
                                cartState, tableState),
                          ],
                        ),
                        ListenableBuilder(
                          listenable: _foodItemSize,
                          builder: (context, _) {
                            return SizedBox(
                              height: _foodItemSize.value.height,
                              width: _foodItemSize.value.width,
                              child: Container(
                                height: _foodItemSize.value.height,
                                width: _foodItemSize.value.width,
                                color: AppColors.lavender,
                              )
                                  .animate(
                                    autoPlay: false,
                                    controller: _animationController,
                                  )
                                  .scale(
                                    duration: 2.seconds,
                                    begin: const Offset(1, 1),
                                    end: Offset.zero,
                                  ),
                            )
                                .animate(
                                  autoPlay: false,
                                  controller: _animationController,
                                  onComplete: (controller) {
                                    _resetAnimation();
                                    _animationController.reset();
                                  },
                                )
                                .followPath(
                                    path: _path,
                                    duration: 2.seconds,
                                    curve: Curves.easeInOutCubic);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            _ => Container(),
          });
        },
      ),
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

  Widget _buildFloatingButton(OrderModel orderModel, UserModel user) {
    return FloatingActionButton(
      key: _cartKey,
      backgroundColor: AppColors.themeColor,
      onPressed: () => context.push(AppRoute.carts, extra: user),
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

  void triggerAnimation() {
    _animationController.reset();
    _animationController.forward();
  }

// Example usage of RenderBox and localToGlobal
  void calculatePathAndAnimate(int index) {
    _resetAnimation();
    if (_cartKey.currentContext != null &&
        _managerList.keys[index].currentContext != null) {
      var foodContext = _managerList.keys[index].currentContext!;

      _foodPosition = (foodContext.findRenderObject() as RenderBox)
          .localToGlobal(Offset.zero);
      // print(_foodPosition);
      _foodItemSize.value = foodContext.size!;
      cartBottomRight = (foodContext.findRenderObject() as RenderBox)
          .localToGlobal(foodContext.size!.bottomRight(Offset.zero));
      _path = Path()
        ..moveTo(_foodPosition.dx, _foodPosition.dy)
        ..relativeLineTo(-20, -20)
        ..lineTo(cartBottomRight.dx - _foodItemSize.value.width,
            cartBottomRight.dy - _foodItemSize.value.height);

      // Trigger animation
      triggerAnimation();
    }
  }

  @override
  bool get wantKeepAlive => true;
}
