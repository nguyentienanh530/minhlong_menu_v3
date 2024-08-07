import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widgets/error_screen.dart';
import 'package:minhlong_menu_client_v3/common/widgets/loading.dart';
import 'package:minhlong_menu_client_v3/common/widgets/no_product.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/core/utils.dart';
import 'package:minhlong_menu_client_v3/features/food/cubit/search_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';
import 'package:tiengviet/tiengviet.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widgets/common_back_button.dart';
import '../../../../common/widgets/common_text_field.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_const.dart';
import '../../bloc/food_bloc.dart';
import '../../data/model/food_item.dart';

class SearchFoodScreen extends StatelessWidget {
  const SearchFoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              FoodBloc(foodRepository: context.read<FoodRepository>()),
        ),
        BlocProvider(
          create: (context) => SearchCubit(),
        ),
      ],
      child: const SearchFoodView(),
    );
  }
}

class SearchFoodView extends StatefulWidget {
  const SearchFoodView({super.key});

  @override
  State<SearchFoodView> createState() => _SearchFoodViewState();
}

class _SearchFoodViewState extends State<SearchFoodView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _searchController.clear();
  }

  @override
  void initState() {
    super.initState();
    context.read<FoodBloc>().add(FoodFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 30),
        child: const AfterSearchUI()
            .animate()
            .slideX(
                begin: -0.1,
                end: 0,
                curve: Curves.easeInOutCubic,
                duration: 500.ms)
            .fadeIn(curve: Curves.easeInOutCubic, duration: 500.ms),
      ),
    );
  }

  _buildAppbar() {
    return AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: CommonBackButton(onTap: () => context.pop()),
        title: _buildSearch()
            .animate()
            .slideX(
                begin: 0.3,
                end: 0,
                curve: Curves.easeInOutCubic,
                duration: 500.ms)
            .fadeIn(curve: Curves.easeInOutCubic, duration: 500.ms));
  }

  Widget _buildSearch() {
    return CommonTextField(
        filled: false,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(defaultBorderRadius),
            borderSide: BorderSide(color: context.colorScheme.primary)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          borderSide:
              BorderSide(color: context.colorScheme.outline.withOpacity(0.2)),
        ),
        controller: _searchController,
        onChanged: (value) {
          _searchController.text = value;
          context.read<SearchCubit>().onSearchChange(value);
        },
        hintText: "Tìm kiếm",
        hintStyle: context.bodyMedium,
        style: context.bodyMedium,
        suffixIcon: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.read<SearchCubit>().clearSearch();
              _searchController.clear();
            }),
        prefixIcon: const Icon(Icons.search));
  }
}

class AfterSearchUI extends StatefulWidget {
  const AfterSearchUI({super.key});

  @override
  State<AfterSearchUI> createState() => _AfterSearchUIState();
}

class _AfterSearchUIState extends State<AfterSearchUI> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FoodBloc, FoodState>(
      builder: (context, state) {
        var searchCubit = context.watch<SearchCubit>().state;
        return switch (state) {
          FoodFetchInProgress() => const Loading(),
          FoodFetchEmpty() => const NoProduct(),
          FoodFetchFailure() => ErrorScreen(errorMessage: state.message),
          FoodFetchSuccess() => _buildBody(state.food.foodItems, searchCubit),
          _ => const SizedBox(),
        };
      },
    );
  }

  Widget _buildBody(List<FoodItem> foods, String text) => ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: foods.length,
      itemBuilder: (context, i) {
        if (foods[i]
                .name
                .toString()
                .toLowerCase()
                .contains(text.toLowerCase()) ||
            TiengViet.parse(foods[i].name.toString().toLowerCase())
                .contains(text.toLowerCase())) {
          return _buildItemSearch(context, foods[i]);
        }
        return const SizedBox();
      });

  Widget _buildItemSearch(BuildContext context, FoodItem food) {
    return GestureDetector(
      onTap: () => context.push(AppRoute.foodsDetail, extra: food),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: defaultPadding, vertical: defaultPadding / 5),
        child: Card(
          elevation: 1,
          surfaceTintColor: context.colorScheme.surfaceTint,
          child: SizedBox(
            height: 80,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildImage(food),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildTitle(context, food),
                        // _buildCategory(context, food),
                        _buildPrice(context, food)
                      ]),
                ),
                const SizedBox(width: 8)
              ]
                  .animate(interval: 50.ms)
                  .slideX(
                      begin: -0.1,
                      end: 0,
                      curve: Curves.easeInOutCubic,
                      duration: 500.ms)
                  .fadeIn(
                    curve: Curves.easeInOutCubic,
                    duration: 500.ms,
                  ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(FoodItem food) {
    return Container(
      margin: const EdgeInsets.all(defaultPadding / 2),
      height: 80,
      width: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: context.colorScheme.surface.withOpacity(0.3),
        image: DecorationImage(
            image: NetworkImage('${ApiConfig.host}${food.image1}'),
            fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildTitle(BuildContext context, FoodItem food) {
    return FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          food.name,
          style: context.bodyMedium,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ));
  }

  Widget _buildPrice(BuildContext context, FoodItem food) {
    double discountAmount = (food.price! * food.discount!.toDouble()) / 100;
    double discountedPrice = food.price! - discountAmount;
    return food.isDiscount == false
        ? Text(
            '${Ultils.currencyFormat(double.parse(food.price.toString()))} ₫',
            style: context.bodyMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary))
        : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Row(children: [
              Text(
                  '${Ultils.currencyFormat(double.parse(food.price.toString()))} ₫',
                  style: TextStyle(
                      decoration: TextDecoration.lineThrough,
                      decorationThickness: 2.0,
                      decorationColor: context.colorScheme.primary,
                      color: context.colorScheme.outline,
                      fontWeight: FontWeight.bold)),
              10.horizontalSpace,
              Text(
                  '${Ultils.currencyFormat(double.parse(discountedPrice.toString()))} ₫',
                  style: context.bodyMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: context.colorScheme.primary))
            ])
          ]);
  }
}
