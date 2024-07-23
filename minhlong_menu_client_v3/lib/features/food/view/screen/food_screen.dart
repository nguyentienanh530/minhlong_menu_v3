import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/features/cart/cubit/cart_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/cart_button.dart';
import '../../../../common/widget/common_back_button.dart';
import '../../../../common/widget/common_item_food.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/error_widget.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../../core/utils.dart';
import '../../../order/data/model/order_detail.dart';
import '../../../order/data/model/order_model.dart';
import '../../../table/cubit/table_cubit.dart';
import '../../../table/data/model/table_model.dart';
import '../../bloc/food_bloc.dart';
import '../../data/model/food_item.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key, required this.property});
  final String property;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FoodBloc(foodRepository: context.read<FoodRepository>()),
      child: FoodView(property: property),
    );
  }
}

class FoodView extends StatefulWidget {
  const FoodView({super.key, required this.property});
  final String property;

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  late String property;
  final _scrollController = ScrollController();
  int _page = 1;
  var _isLoadMore = false;
  var _isMaxData = false;

  @override
  void initState() {
    super.initState();

    property = widget.property;
    getData(property);

    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_isLoadMore) return;
    if (_isMaxData) return;
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      _isLoadMore = true;
      _page = _page + 1;
      context.read<FoodBloc>().add(
            FoodLoadMore(
              20,
              property,
              page: _page,
            ),
          );
      _isLoadMore = false;
    }
  }

  void getData(String property, {int limit = 20}) {
    context.read<FoodBloc>().add(
          FoodFetched(
            page: 1,
            property: property,
            limit: limit,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    var cartState = context.watch<CartCubit>().state;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: AppColors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonBackButton(onTap: () => context.pop()),
              Text(
                property.contains('created_at')
                    ? 'Mới nhất'
                    : 'Được chọn nhiều',
                style: kHeadingStyle.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              CartButton(
                onPressed: () => context.push(AppRoute.carts),
                number: cartState.orderDetail.length.toString(),
                colorIcon: AppColors.themeColor,
              )
            ],
          ),
        ),
        body: BlocBuilder<FoodBloc, FoodState>(
          builder: (context, state) {
            var cart = context.watch<CartCubit>().state;
            var table = context.watch<TableCubit>().state;
            if (state is FoodFetchInProgress) {
              return const Loading();
            } else if (state is FoodFetchFailure) {
              return ErrWidget(error: state.message);
            } else if (state is FoodFetchEmpty) {
              return const EmptyWidget();
            } else {
              var food = state.food;
              if (food.paginationModel != null) {
                _page > food.paginationModel!.totalPage
                    ? _isMaxData = true
                    : _isMaxData = false;
              }

              return CustomScrollView(
                controller: _scrollController,
                // physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverGrid(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => CommonItemFood(
                          addToCartOnTap: () => _handleOnTapAddToCart(
                              cart, table, state.food.foodItems[index]),
                          food: state.food.foodItems[index],
                        ),
                        childCount: food.foodItems.length,
                      ),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 9 / 11,
                        mainAxisSpacing: defaultPadding / 2,
                        crossAxisSpacing: defaultPadding / 2,
                        crossAxisCount: 2,
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: state is FoodLoadMoreState
                        ? Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            alignment: Alignment.center,
                            child: const Loading(),
                          )
                        : const SizedBox(),
                  ),
                ],
              );
            }
          },
        ));
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
