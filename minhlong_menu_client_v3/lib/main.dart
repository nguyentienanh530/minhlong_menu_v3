import 'package:dio/dio.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_client_v3/Routes/app_route.dart';
import 'package:minhlong_menu_client_v3/core/app_theme.dart';
import 'package:minhlong_menu_client_v3/features/auth/bloc/auth_bloc.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/provider/remote/auth_api.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/respositories/auth_repository.dart';
import 'package:minhlong_menu_client_v3/features/home/data/provider/home_api.dart';
import 'package:minhlong_menu_client_v3/features/home/data/repository/home_repo.dart';
import 'package:minhlong_menu_client_v3/features/theme/cubit/scheme_cubit.dart';
import 'package:minhlong_menu_client_v3/features/theme/cubit/theme_cubit.dart';
import 'package:minhlong_menu_client_v3/features/theme/data/theme_local_datasource.dart';
import 'package:minhlong_menu_client_v3/features/user/cubit/user_cubit.dart';
import 'package:minhlong_menu_client_v3/features/user/data/user_local_datasource/user_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observer.dart';
import 'common/network/dio_client.dart';
import 'common/network/dio_interceptor.dart';
import 'core/api_config.dart';
import 'features/cart/cubit/cart_cubit.dart';
import 'features/food/cubit/item_size_cubit.dart';
import 'features/food/data/provider/food_api.dart';
import 'features/food/data/repositories/food_repository.dart';
import 'features/order/data/provider/order_api.dart';
import 'features/order/data/repositories/order_repository.dart';
import 'features/table/cubit/table_cubit.dart';
import 'features/user/bloc/user_bloc.dart';
import 'features/user/data/provider/user_api.dart';
import 'features/user/data/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  final sf = await SharedPreferences.getInstance();
  dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: ApiConfig.connectionTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    responseType: ResponseType.json,
  ));
  dio.interceptors.add(
    DioInterceptor(sf),
  );
  var theme = await ThemeLocalDatasource(sf).getDartTheme() ?? false;
  var scheme =
      await ThemeLocalDatasource(sf).getSchemeTheme() ?? listScheme.first.key;
  runApp(
    MainApp(
      sf: sf,
      theme: theme,
      scheme: scheme,
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp(
      {super.key, required this.sf, required this.theme, required this.scheme});

  final SharedPreferences sf;
  final bool theme;
  final String? scheme;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            authApi: AuthApi(dio: dio),
            authLocalDatasource: AuthLocalDatasource(sf),
            userLocalDatasource: UserLocalDatasource(sf),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userApi: UserApi(
              dio: dio,
            ),
            userLocalDatasource: UserLocalDatasource(sf),
          ),
        ),
        RepositoryProvider(
          create: (context) => FoodRepository(
            foodApi: FoodApi(dio: dio),
          ),
        ),
        RepositoryProvider(create: (context) => HomeRepo(HomeApi(dio))),
        RepositoryProvider(
          create: (context) => OrderRepository(
            orderApi: OrderApi(dio),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              context.read<AuthRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => ThemeCubit(),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => CartCubit(),
          ),
          BlocProvider(
            create: (context) => TableCubit(),
          ),
          BlocProvider(
            create: (context) => ItemSizeCubit(),
          ),
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(
            create: (context) => SchemeCubit(),
          ),
        ],
        child: AppContent(
          sf: sf,
          theme: theme,
          scheme: scheme,
        ),
      ),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent(
      {super.key, required this.sf, required this.theme, required this.scheme});
  final SharedPreferences sf;
  final bool theme;
  final String? scheme;

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthAuthenticateStarted());
    context.read<ThemeCubit>().changeTheme(widget.theme);
    context.read<SchemeCubit>().changeScheme(widget.scheme!);
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;

    if (state is AuthInitial) {
      return Container();
    }

    var themeState = context.watch<ThemeCubit>().state;
    var schemeState = context.watch<SchemeCubit>().state;

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: AppRoute.routes,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: themeState
              ? AppTheme(scheme: schemeState).darkTheme
              : AppTheme(scheme: schemeState).lightTheme,
        );
      },
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}
