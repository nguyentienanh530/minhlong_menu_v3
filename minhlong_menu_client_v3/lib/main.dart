import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minhlong_menu_client_v3/Routes/app_route.dart';
import 'package:minhlong_menu_client_v3/features/auth/bloc/auth_bloc.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/provider/remote/auth_api.dart';
import 'package:minhlong_menu_client_v3/features/auth/data/respositories/auth_repository.dart';
import 'package:minhlong_menu_client_v3/features/cart/cubit/cart_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/cubit/item_size_cubit.dart';
import 'package:minhlong_menu_client_v3/features/food/data/provider/food_api.dart';
import 'package:minhlong_menu_client_v3/features/order/bloc/order_bloc.dart';
import 'package:minhlong_menu_client_v3/features/order/data/provider/order_api.dart';
import 'package:minhlong_menu_client_v3/features/order/data/repositories/order_repository.dart';
import 'package:minhlong_menu_client_v3/features/table/cubit/table_cubit.dart';
import 'package:minhlong_menu_client_v3/features/user/bloc/user_bloc.dart';
import 'package:minhlong_menu_client_v3/features/user/data/provider/user_api.dart';
import 'package:minhlong_menu_client_v3/features/user/data/repositories/user_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'bloc_observer.dart';
import 'common/network/dio_client.dart';
import 'common/network/dio_interceptor.dart';
import 'core/app_colors.dart';
import 'features/food/data/repositories/food_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  final sf = await SharedPreferences.getInstance();
  dio.interceptors.add(DioInterceptor(sf));
  runApp(DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => MainApp(sf: sf)));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key, required this.sf});

  final SharedPreferences sf;

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            authApi: AuthApi(dio: dio),
            authLocalDatasource: AuthLocalDatasource(widget.sf),
          ),
        ),
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
          create: (context) => UserRepository(
            userApi: UserApi(dio: dio),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
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
            create: (context) =>
                UserBloc(userRepository: context.read<UserRepository>()),
          )
        ],
        child: const AppContent(),
      ),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({
    super.key,
  });

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthAuthenticateStarted());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    if (state is AuthInitial) {
      return Container();
    }

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          // ignore: deprecated_member_use
          useInheritedMediaQuery: true,
          locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          routerConfig: AppRoute.routes,
          scrollBehavior: MyCustomScrollBehavior(),
          theme: ThemeData(
            fontFamily: GoogleFonts.rubik().fontFamily,
            scaffoldBackgroundColor: AppColors.background,
            textTheme: const TextTheme(
                displaySmall: TextStyle(color: AppColors.white),
                displayLarge: TextStyle(color: AppColors.white),
                displayMedium: TextStyle(color: AppColors.white)),
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: MaterialColor(
                AppColors.themeColor.value,
                getSwatch(AppColors.themeColor),
              ),
            ),
          ),
        );
      },
    );
  }

  Map<int, Color> getSwatch(Color color) {
    final hslColor = HSLColor.fromColor(color);
    final lightness = hslColor.lightness;

    /// if [500] is the default color, there are at LEAST five
    /// steps below [500]. (i.e. 400, 300, 200, 100, 50.) A
    /// divisor of 5 would mean [50] is a lightness of 1.0 or
    /// a color of #ffffff. A value of six would be near white
    /// but not quite.
    const lowDivisor = 6;

    /// if [500] is the default color, there are at LEAST four
    /// steps above [500]. A divisor of 4 would mean [900] is
    /// a lightness of 0.0 or color of #000000
    const highDivisor = 5;

    final lowStep = (1.0 - lightness) / lowDivisor;
    final highStep = lightness / highDivisor;

    return {
      50: (hslColor.withLightness(lightness + (lowStep * 5))).toColor(),
      100: (hslColor.withLightness(lightness + (lowStep * 4))).toColor(),
      200: (hslColor.withLightness(lightness + (lowStep * 3))).toColor(),
      300: (hslColor.withLightness(lightness + (lowStep * 2))).toColor(),
      400: (hslColor.withLightness(lightness + lowStep)).toColor(),
      500: (hslColor.withLightness(lightness)).toColor(),
      600: (hslColor.withLightness(lightness - highStep)).toColor(),
      700: (hslColor.withLightness(lightness - (highStep * 2))).toColor(),
      800: (hslColor.withLightness(lightness - (highStep * 3))).toColor(),
      900: (hslColor.withLightness(lightness - (highStep * 4))).toColor(),
    };
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}
