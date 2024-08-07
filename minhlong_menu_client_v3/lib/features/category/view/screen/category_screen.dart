import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/Routes/app_route.dart';
import 'package:minhlong_menu_client_v3/common/widgets/cart_button.dart';
import 'package:minhlong_menu_client_v3/common/widgets/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widgets/error_screen.dart';
import 'package:minhlong_menu_client_v3/common/widgets/loading.dart';
import 'package:minhlong_menu_client_v3/core/api_config.dart';
import 'package:minhlong_menu_client_v3/core/app_asset.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_model.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import '../../../../common/widgets/common_item_food.dart';
import '../../../../common/widgets/error_build_image.dart';
import '../../../../core/app_const.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../food/bloc/food_bloc.dart';
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
    var user = context.watch<UserCubit>().state;
    return Scaffold(body: BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        if (state.food.paginationModel != null) {
          _page > state.food.paginationModel!.totalPage
              ? _isMaxData = true
              : _isMaxData = false;
        }

        if (state is FoodOnCategoryFetchInProgress) {
          return const Loading();
        } else if (state is FoodOnCategoryFetchFailure) {
          return ErrorScreen(
            errorMessage: state.message,
          );
        } else {
          return CustomScrollView(
            controller: controller,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                stretch: true,
                leading: CommonBackButton(onTap: () => context.pop()),
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                expandedHeight: context.isPortrait
                    ? 0.4 * context.sizeDevice.height
                    : 0.4 * context.sizeDevice.width,
                flexibleSpace: FlexibleSpaceBar(
                  background: _buildHeader(_categoryModel),
                ),
                actions: [
                  CartButton(
                      onPressed: () =>
                          context.push(AppRoute.carts, extra: user),
                      number: cart.order.orderDetail.length.toString(),
                      colorIcon: context.colorScheme.primary),
                  const SizedBox(width: 10),
                ],
              ),
              SliverMainAxisGroup(
                slivers: [
                  SliverToBoxAdapter(
                      child: _buildWidgetWhenFetchSuccess(
                          cart.order, table, state.food)),
                  SliverPadding(
                    padding: const EdgeInsets.all(defaultPadding),
                    sliver: SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: defaultPadding),
                        child: state is FoodLoadMoreState
                            ? const Loading()
                            : const SizedBox(),
                      ),
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
          child: category.image.isEmpty
              ? SvgPicture.asset(
                  AppAsset.noImage,
                  alignment: Alignment.topRight,
                )
              : CachedNetworkImage(
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
                style: context.titleStyleLarge!
                    .copyWith(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                widget.categoryModel.name,
                style: context.titleStyleLarge!.copyWith(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                    height: 1),
              ),
              ValueListenableBuilder(
                valueListenable: _foodCount,
                builder: (context, value, child) {
                  return Text(
                    '$value Món',
                    style: context.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w800,
                        color: context.bodyMedium!.color!.withOpacity(0.5)),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetWhenFetchSuccess(
      OrderModel order, TableModel table, FoodModel food) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _foodCount.value = food.paginationModel?.totalItem ?? 0;
    });

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
      itemCount: food.foodItems.length,
      itemBuilder: (context, index) {
        return CommonItemFood(
          // addToCartOnTap: () =>
          //     _handleOnTapAddToCart(order, table, food.foodItems[index]),
          addToCartOnTap: () => context
              .read<CartCubit>()
              .addToCart(food: food.foodItems[index], table: table),
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
}
