import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import '../../../../common/widget/loading.dart';
import '../../../banner/bloc/banner_bloc.dart';
import '../../../banner/data/repositories/banner_repository.dart';
import '../../../category/bloc/category_bloc.dart';
import '../../../category/data/repositories/category_repository.dart';
import '../../../dinner_table/bloc/dinner_table_bloc.dart';
import '../../../dinner_table/data/repositories/table_repository.dart';
import '../../../food/bloc/food_bloc/food_bloc.dart';
import '../../../food/bloc/search_food_bloc/search_food_bloc.dart';
import '../../../food/data/repositories/food_repository.dart';

import '../../../user/bloc/user_bloc.dart';
import '../../../user/cubit/user_cubit.dart';
import '../../cubit/table_index_selected_cubit.dart';
import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFecthSuccess) {
          context.read<UserCubit>().userChanged(state.user);
        }
      },
      builder: (context, state) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return (switch (state) {
              UserFecthSuccess() => _userFetchSuccess(context),
              UserFecthFailure() => ErrWidget(error: state.errorMessage),
              UserFecthInProgress() => const Loading(),
              _ => const SizedBox.shrink(),
            });
          },
        );
      },
    );
  }

  Widget _userFetchSuccess(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TableIndexSelectedCubit(),
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
      ],
      child: const HomeView(),
    );
  }
}
