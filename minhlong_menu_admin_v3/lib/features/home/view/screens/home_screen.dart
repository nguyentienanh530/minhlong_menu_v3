import 'package:flutter/material.dart';
import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const HomeView();
    // return BlocBuilder<UserBloc, UserState>(
    //   builder: (context, state) {
    //     return Scaffold(
    //       body: BlocBuilder<UserBloc, UserState>(
    //         builder: (context, state) {
    //           return (switch (state) {
    //             UserFecthSuccess() => _userFetchSuccess(context, state.user),
    //             UserFecthFailure() => ErrWidget(error: state.errorMessage),
    //             UserFecthInProgress() => const Loading(),
    //             _ => Container(),
    //           });
    //         },
    //       ),
    //     );

    //     // return state is UserFecthSuccess
    //     //     ? _userFetchSuccess(context, state.user)
    //     //     : const SizedBox.shrink();
    //   },
    // );
  }

  // Widget _userFetchSuccess(BuildContext context, UserModel user) {
  // context.read<UserCubit>().userChanged(user);
  // return MultiBlocProvider(
  //   providers: [
  //     BlocProvider(
  //       create: (context) => TableIndexSelectedCubit(),
  //     ),
  //     BlocProvider(
  //       create: (context) => FoodBloc(context.read<FoodRepository>()),
  //     ),
  //     BlocProvider(
  //       create: (context) => DinnerTableBloc(
  //         context.read<DinnerTableRepository>(),
  //       ),
  //     ),
  //     BlocProvider(
  //       create: (context) => CategoryBloc(
  //         categoryRepository: context.read<CategoryRepository>(),
  //       ),
  //     ),
  //     BlocProvider(
  //       create: (context) => BannerBloc(
  //         bannerRepository: context.read<BannerRepository>(),
  //       ),
  //     ),
  //   ],
  //   child: const HomeView(),
  // );
  // return const HomeView();
  // }
}
