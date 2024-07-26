import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:minhlong_menu_client_v3/features/home/bloc/home_bloc.dart';
import 'package:minhlong_menu_client_v3/features/home/data/repository/home_repo.dart';
import 'package:minhlong_menu_client_v3/features/user/bloc/user_bloc.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import '../../../../common/widget/error_screen.dart';
import '../../../../common/widget/loading.dart';
import '../../../order/bloc/order_bloc.dart';
import '../../../order/data/repositories/order_repository.dart';
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
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserFecthSuccess) {
          context.read<UserCubit>().userChanged(state.user);
        }
      },
      builder: (context, state) {
        return (switch (state) {
          UserFecthSuccess() => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => OrderBloc(
                      orderRepository: context.read<OrderRepository>()),
                ),
                BlocProvider(
                  create: (context) => HomeBloc(context.read<HomeRepo>()),
                ),
              ],
              child: const HomeView(),
            ),
          UserFecthFailure() => ErrorScreen(errorMessage: state.errorMessage),
          UserFecthInProgress() => const Loading(),
          _ => const SizedBox.shrink(),
        });
      },
    );
  }
}
