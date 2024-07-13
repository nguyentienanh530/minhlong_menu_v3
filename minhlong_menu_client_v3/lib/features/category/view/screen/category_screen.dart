import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/grid_item_food.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/core/api_config.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_string.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/food/data/model/food_model.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../food/bloc/food_bloc.dart';
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

  @override
  void initState() {
    super.initState();
    _categoryModel = widget.categoryModel;
    _getData(limit: 10);
  }

  @override
  void dispose() {
    super.dispose();
    _foodCount.dispose();
  }

  void _getData({required int limit}) {
    context.read<FoodBloc>().add(FoodOnCategoryFetched(
        page: 1, limit: limit, categoryID: _categoryModel.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
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
        ),
        SliverToBoxAdapter(
          child: _buildBody(),
        ),
      ],
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

  Widget _buildBody() {
    return Builder(builder: (context) {
      var foodState = context.watch<FoodBloc>().state;

      return (switch (foodState) {
        FoodOnCategoryFetchInProgress() => const Loading(),
        FoodOnCategoryFetchEmpty() => const EmptyWidget(),
        FoodOnCategoryFetchFailure() => ErrWidget(error: foodState.message),
        FoodOnCategoryFetchSuccess() =>
          _buildWidgetWhenFetchSuccess(foodState.food),
        _ => const SizedBox()
      });
    });
  }

  Widget _buildWidgetWhenFetchSuccess(FoodModel food) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _foodCount.value = food.paginationModel?.totalItem ?? 0;
    });

    return GridItemFood(
      crossAxisCount: 2,
      aspectRatio: 9 / 12,
      isScroll: false,
      foods: food.foodItems,
    );
  }
}
