import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/Routes/app_route.dart';
import 'package:minhlong_menu_client_v3/common/widget/cart_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/core/api_config.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_model.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import '../../../../common/snackbar/app_snackbar.dart';
import '../../../../common/widget/common_item_food.dart';
// import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../core/app_const.dart';
import '../../../../core/utils.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../food/bloc/food_bloc.dart';
import '../../../food/data/model/food_item.dart';
import '../../../order/data/model/order_detail.dart';
import '../../../order/data/model/order_model.dart';
import '../../../table/cubit/table_cubit.dart';
import '../../../table/data/model/table_model.dart';
import '../../data/model/category_model.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FoodBloc(foodRepository: context.read<FoodRepository>()),
      child: CategoryView(categoryModel: categoryModel),
    );
  }
}

class CategoryView extends StatefulWidget {
  const CategoryView({super.key, required this.categoryModel});
  final CategoryModel categoryModel;

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  late final CategoryModel _categoryModel;
  final _foodCount = ValueNotifier(0);
  late ScrollController controller;
  var _page = 1;
  final _isLoadMore = ValueNotifier(false);
  var _isMaxData = false;
  final _limit = 10;

  @override
  void initState() {
    super.initState();
    _categoryModel = widget.categoryModel;
    _getData(page: _page);
    controller = ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    super.dispose();
    _foodCount.dispose();
    controller.removeListener(_scrollListener);
    controller.dispose();
  }

  void _getData({required int page}) {
    context.read<FoodBloc>().add(FoodOnCategoryFetched(
        page: page, limit: _limit, categoryID: _categoryModel.id));
  }

  void _scrollListener() {
    if (_isLoadMore.value) return;
    if (_isMaxData) return;

    if (controller.position.pixels == controller.position.maxScrollExtent) {
      _isLoadMore.value = true;
      _page = _page + 1;
      context.read<FoodBloc>().add(FoodOnCategoryLoadMore(
          page: _page, limit: _limit, categoryID: _categoryModel.id));

      _isLoadMore.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    var cart = context.watch<CartCubit>().state;
    var table = context.watch<TableCubit>().state;
    return Scaffold(body: BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state.food.paginationModel != null) {
          _page > state.food.paginationModel!.totalPage
              ? _isMaxData = true
              : _isMaxData = false;
        }

        if (state is FoodOnCategoryFetchInProgress) {
          return const SliverToBoxAdapter(child: Loading());
        } else if (state is FoodOnCategoryFetchFailure) {
          return SliverToBoxAdapter(child: ErrWidget(error: state.message));
        } else {
          // return _buildWidgetWhenFetchSuccess(order, table, state.food);
          return CustomScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                leading: CommonBackButton(onTap: () => context.pop()),
                backgroundColor: AppColors.transparent,
                expandedHeight: context.isPortrait
                    ? 0.4 * context.sizeDevice.height
                    : 0.4 * context.sizeDevice.width,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeader(_categoryModel),
                ),
                actions: [
                  CartButton(
                      onPressed: () => context.push(AppRoute.carts),
                      number: cart.orderDetail.length.toString(),
                      colorIcon: AppColors.themeColor),
                  const SizedBox(width: 10),
                ],
              ),
              SliverMainAxisGroup(
                slivers: [
                  _buildWidgetWhenFetchSuccess(cart, table, state.food),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: defaultPadding),
                      child: state is FoodOnCategoryLoadMore
                          ? const Loading()
                          : const SizedBox(),
                    ),
                  ),
                ],
              ),
            ],
          );
        }
      },
    ));
  }

  Widget _buildHeader(CategoryModel category) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.centerRight,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(),
          width: double.infinity,
          child: CachedNetworkImage(
            imageUrl: '${ApiConfig.host}${category.image}',
            errorWidget: errorBuilderForImage,
            fit: BoxFit.cover,
          ),
        ),
        Positioned(
          top: context.isPortrait
              ? context.sizeDevice.height * 0.2
              : context.sizeDevice.width * 0.2,
          left: 40,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppString.category,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              ),
              Text(
                widget.categoryModel.name,
                style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w900,
                    color: AppColors.themeColor,
                    height: 1),
              ),
              ValueListenableBuilder(
                valueListenable: _foodCount,
                builder: (context, value, child) {
                  return Text(
                    '$value Món',
                    style:
                        kBodyStyle.copyWith(color: AppColors.secondTextColor),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget _buildBody(OrderModel order, TableModel table) {
  //   return BlocBuilder<FoodBloc, FoodState>(builder: (context, state) {
  //     // return (switch (state) {
  //     //   FoodOnCategoryFetchInProgress() =>
  //     //     const SliverToBoxAdapter(child: Loading()),
  //     //   FoodOnCategoryFetchEmpty() =>
  //     //     const SliverToBoxAdapter(child: EmptyWidget()),
  //     //   FoodOnCategoryFetchFailure() =>
  //     //     SliverToBoxAdapter(child: ErrWidget(error: state.message)),
  //     //   FoodOnCategoryFetchSuccess() =>

  //     //   _ => const SliverToBoxAdapter(child: Loading())
  //     // });
  //   });
  // }

  Widget _buildWidgetWhenFetchSuccess(
      OrderModel order, TableModel table, FoodModel food) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _foodCount.value = food.paginationModel?.totalItem ?? 0;
    });

    return SliverGrid.builder(
      itemCount: food.foodItems.length,
      itemBuilder: (context, index) {
        return CommonItemFood(
          addToCartOnTap: () =>
              _handleOnTapAddToCart(order, table, food.foodItems[index]),
          food: food.foodItems[index],
        );
      },
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 9 / 11,
        mainAxisSpacing: defaultPadding / 2,
        crossAxisSpacing: defaultPadding / 2,
        crossAxisCount: 2,
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
