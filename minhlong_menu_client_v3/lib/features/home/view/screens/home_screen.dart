import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_client_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_client_v3/core/utils.dart';
import 'package:minhlong_menu_client_v3/features/auth/bloc/auth_bloc.dart';
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
    return Scaffold(
      body: BlocConsumer<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserFecthSuccess) {
            context.read<UserCubit>().userChanged(state.user);
            if (Ultils.subcriptionEndDate(state.user.subscriptionEndDate) <=
                0) {
              AppDialog.showSubscriptionDialog(context);
            }
          }

          if (state is UserFecthFailure) {
            context.read<AuthBloc>().add(AuthLogoutStarted());
            // context.read<AuthBloc>().add(AuthAuthenticateStarted());
            // context.go(AppRoute.login);
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
      ),
    );
  }
}
