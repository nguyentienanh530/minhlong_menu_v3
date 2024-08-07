import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widgets/loading.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/cart/cubit/cart_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import '../../../../Routes/app_route.dart';
import '../../../../common/widgets/cart_button.dart';
import '../../../../common/widgets/common_back_button.dart';
import '../../../../common/widgets/common_item_food.dart';
import '../../../../common/widgets/empty_widget.dart';
import '../../../../common/widgets/error_widget.dart';
import '../../../../core/app_const.dart';
import '../../../table/cubit/table_cubit.dart';
import '../../bloc/food_bloc.dart';

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
    var user = context.watch<UserCubit>().state;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: CommonBackButton(onTap: () => context.pop()),
        title: Text(
          property.contains('created_at') ? 'Mới nhất' : 'Được chọn nhiều',
          style: context.titleStyleLarge!.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CartButton(
            onPressed: () => context.push(AppRoute.carts, extra: user),
            number: cartState.order.orderDetail.length.toString(),
            colorIcon: context.colorScheme.primary,
          ),
          10.horizontalSpace
        ],
      ),
      body: BlocBuilder<FoodBloc, FoodState>(
        builder: (context, state) {
          var table = context.watch<TableCubit>().state;
          if (state is FoodFetchInProgress) {
            return const Loading();
          } else if (state is FoodFetchFailure) {
            return ErrWidget(error: state.message);
          } else if (state is FoodFetchEmpty) {
            return const EmptyWidget();
          } else {
            _isLoadMore = false;
            var food = state.food;
            if (food.paginationModel != null) {
              _page > food.paginationModel!.totalPage
                  ? _isMaxData = true
                  : _isMaxData = false;
            }

            return CustomScrollView(
              controller: _scrollController,
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(defaultPadding),
                    itemBuilder: (context, index) => CommonItemFood(
                      // addToCartOnTap: () => _handleOnTapAddToCart(
                      //     cart, table, state.food.foodItems[index]),
                      addToCartOnTap: () => context.read<CartCubit>().addToCart(
                            food: state.food.foodItems[index],
                            table: table,
                          ),
                      food: state.food.foodItems[index],
                    ),
                    itemCount: state.food.foodItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 9 / 11,
                      mainAxisSpacing: defaultPadding / 2,
                      crossAxisSpacing: defaultPadding / 2,
                      crossAxisCount: 2,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: defaultPadding),
                  sliver: SliverToBoxAdapter(
                    child: state is FoodLoadMoreState
                        ? Container(
                            padding: const EdgeInsets.only(bottom: 16),
                            alignment: Alignment.center,
                            child: const Loading(),
                          )
                        : const SizedBox(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
