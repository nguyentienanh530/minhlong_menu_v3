import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:minhlong_menu_client_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_client_v3/core/utils.dart';
import 'package:minhlong_menu_client_v3/features/auth/bloc/auth_bloc.dart';
import 'package:minhlong_menu_client_v3/features/home/bloc/home_bloc.dart';
import 'package:minhlong_menu_client_v3/features/home/data/repository/home_repo.dart';
import 'package:minhlong_menu_client_v3/features/user/bloc/user_bloc.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Routes/app_route.dart';
import '../../../../common/widgets/error_screen.dart';
import '../../../../common/widgets/loading.dart';
import '../../../auth/data/auth_local_datasource/auth_local_datasource.dart';
import '../../../auth/data/model/access_token.dart';
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
    initData();
  }

  void initData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var accessToken = await AuthLocalDatasource(prefs).getAccessToken();
    if (accessToken != null) {
      _handleGetUser(accessToken);
    } else {
      if (!mounted) return;
      context.read<AuthBloc>().add(AuthLogoutStarted());
    }
  }

  void _handleGetUser(AccessToken accessToken) async {
    // check token is expired
    var hasExpired = JwtDecoder.isExpired(accessToken.accessToken);
    var hasExpiredRefresh = JwtDecoder.isExpired(accessToken.refreshToken);
    if (!hasExpired && !hasExpiredRefresh) {
      context.read<UserBloc>().add(UserFetched(accessToken));
    }
    if (hasExpiredRefresh) {
      if (!mounted) return;
      context.read<AuthBloc>().add(AuthLogoutStarted());
    }
    if (hasExpired) {
      if (!mounted) return;
      context
          .read<AuthBloc>()
          .add(AuthEventRefreshTokenStarted(accessToken.refreshToken));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLogoutSuccess) {
            context.read<AuthBloc>().add(AuthAuthenticateStarted());
            context.go(AppRoute.login);
          }
          if (state is AuthRefreshTokenSuccess) {
            context.read<UserBloc>().add(UserFetched(state.accessToken));
          }

          if (state is AuthRefreshTokenFailure) {
            context.read<AuthBloc>().add(AuthLogoutStarted());
          }
        },
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserFecthSuccess) {
              context.read<UserCubit>().userChanged(state.user);
              if (Ultils.subcriptionEndDate(state.user.expiredAt) <= 0) {
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
              UserFecthFailure() =>
                ErrorScreen(errorMessage: state.errorMessage),
              UserFecthInProgress() => const Loading(),
              _ => const SizedBox.shrink(),
            });
          },
        ),
      ),
    );
  }
}
