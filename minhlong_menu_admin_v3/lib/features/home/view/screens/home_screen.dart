import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/network/dio_client.dart';
import '../../../banner/bloc/banner_bloc.dart';
import '../../../banner/data/provider/banner_api.dart';
import '../../../banner/data/repositories/banner_repository.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/provider/category_api.dart';
import '../../../category/data/repositories/category_repository.dart';
import '../../../dashboard/data/provider/info_api.dart';
import '../../../dashboard/data/respositories/info_respository.dart';
import '../../../dinner_table/bloc/dinner_table_bloc.dart';
import '../../../dinner_table/data/provider/dinner_table_api.dart';
import '../../../dinner_table/data/repositories/table_repository.dart';
import '../../../food/bloc/food_bloc/food_bloc.dart';
import '../../../food/bloc/search_food_bloc/search_food_bloc.dart';
import '../../../food/data/provider/food_api.dart';
import '../../../food/data/repositories/food_repository.dart';
import '../../../order/cubit/order_socket_cubit.dart';
import '../../../order/data/provider/order_api.dart';
import '../../../order/data/repositories/order_repository.dart';
import '../../../user/bloc/user_bloc.dart';
import '../../../user/data/provider/user_api.dart';
import '../../../user/data/repositories/user_repository.dart';
import '../../../web_socket_client/cubit/web_socket_client_cubit.dart';
import '../../cubit/table_index_selected_cubit.dart';
import 'home_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => FoodRepository(
            FoodApi(
              dio,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => DinnerTableRepository(
            dinnerTableApi: DinnerTableApi(
              dio,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => CategoryRepository(
            categoryApi: CategoryApi(dio: dio),
          ),
        ),
        RepositoryProvider(
          create: (context) => BannerRepository(
            bannerApi: BannerApi(
              dio: dio,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => InfoRespository(
            InfoApi(dio),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userApi: UserApi(
              dio: dio,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => OrderRepository(
            orderApi: OrderApi(dio),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => WebSocketClientCubit(),
          ),
          BlocProvider(
            create: (context) => TableIndexSelectedCubit(),
          ),
          BlocProvider(
            create: (context) => OrderSocketCubit(),
          ),
          BlocProvider(
            create: (context) => FoodBloc(context.read<FoodRepository>()),
          ),
          BlocProvider(
            create: (context) => SearchFoodBloc(
              context.read<FoodRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => DinnerTableBloc(
              context.read<DinnerTableRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CategoryBloc(
              categoryRepository: context.read<CategoryRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => BannerBloc(
              bannerRepository: context.read<BannerRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          // BlocProvider<AccessTokenCubit>(
          //   create: (context) =>
          //       AccessTokenCubit()..setAccessToken(accessToken),
          // ),
        ],
        child: const HomeView(),
      ),
    );
  }
}
