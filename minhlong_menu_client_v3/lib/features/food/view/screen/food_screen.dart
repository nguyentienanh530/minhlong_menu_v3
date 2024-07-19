import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/features/cart/cubit/cart_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/repositories/food_repository.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/widget/cart_button.dart';
import '../../../../common/widget/common_back_button.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/error_widget.dart';
import '../../../../common/widget/grid_item_food.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_style.dart';
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
  @override
  void initState() {
    super.initState();

    property = widget.property;
    getData(property);
  }

  void getData(String property, {int limit = 10}) {
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
            return (switch (state) {
              FoodFetchInProgress() => const Loading(),
              FoodFetchEmpty() => const EmptyWidget(),
              FoodFetchFailure() => ErrWidget(error: state.message),
              FoodFetchSuccess() => GridItemFood(
                  crossAxisCount: 2,
                  aspectRatio: 9 / 12,
                  isScroll: true,
                  foods: state.food.foodItems,
                ),
              _ => const SizedBox()
            });
          },
        ));
  }
}
