import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_client_v3/common/network/dio_client.dart';
import 'package:minhlong_menu_client_v3/features/banner/data/provider/banner_api.dart';
import 'package:minhlong_menu_client_v3/features/category/data/provider/categories_api.dart';

import '../../../banner/bloc/banner_bloc.dart';
import '../../../banner/data/repositories/banner_repository.dart';
import '../../../cart/cubit/cart_cubit.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/repositories/category_repository.dart';
import '../../../food/cubit/item_size_cubit.dart';
import '../../../food/data/provider/food_api.dart';
import '../../../food/data/repositories/food_repository.dart';
import '../../../order/bloc/order_bloc.dart';
import '../../../order/data/provider/order_api.dart';
import '../../../order/data/repositories/order_repository.dart';
import '../../../table/cubit/table_cubit.dart';

import 'home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FoodRepository(
            foodApi: FoodApi(dio: dio),
          ),
        ),
        RepositoryProvider(
          create: (context) => OrderRepository(
            orderApi: OrderApi(dio),
          ),
        ),
        RepositoryProvider(
          create: (context) => BannerRepository(BannerApi(dio)),
        ),
        RepositoryProvider(
          create: (context) => CategoryRepository(CategoryApi(dio)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => ItemSizeCubit(),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          ),
          BlocProvider(
            create: (context) => TableCubit(),
          ),
          BlocProvider(
            create: (context) =>
                OrderBloc(orderRepository: context.read<OrderRepository>()),
          ),
          BlocProvider(
            create: (context) => BannerBloc(context.read<BannerRepository>())
              ..add(BannerFetched()),
          ),
          BlocProvider(
            create: (context) =>
                CategoryBloc(context.read<CategoryRepository>())
                  ..add(CategoryFetched()),
          ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
