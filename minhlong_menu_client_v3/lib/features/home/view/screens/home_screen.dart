import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_client_v3/common/network/dio_client.dart';
import 'package:minhlong_menu_client_v3/features/banner/data/provider/banner_api.dart';
import 'package:minhlong_menu_client_v3/features/category/data/provider/categories_api.dart';

import '../../../banner/bloc/banner_bloc.dart';
import '../../../banner/data/repositories/banner_repository.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/repositories/category_repository.dart';
import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => BannerRepository(BannerApi(DioClient().dio!)),
        ),
        RepositoryProvider(
          create: (context) =>
              CategoryRepository(CategoryApi(DioClient().dio!)),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
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
