import 'package:device_preview/device_preview.dart';
import 'package:dio/dio.dart';
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
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observer.dart';
import 'common/network/dio_client.dart';
import 'common/network/dio_interceptor.dart';
import 'core/api_config.dart';
import 'core/app_colors.dart';
import 'features/user/bloc/user_bloc.dart';
import 'features/user/data/provider/user_api.dart';
import 'features/user/data/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  final sf = await SharedPreferences.getInstance();
  dio = Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    // headers: {
    //   'Content-Type': 'application/json',
    //   'Accept': 'application/json',
    //   'Authorization': ''
    // },
    connectTimeout: ApiConfig.connectionTimeout,
    receiveTimeout: ApiConfig.receiveTimeout,
    responseType: ResponseType.json,
  ));
  dio.interceptors.add(
    DioInterceptor(sf),
  );
  runApp(DevicePreview(
      // enabled: !kReleaseMode,
      enabled: false,
      builder: (context) => MainApp(sf: sf)));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key, required this.sf});

  final SharedPreferences sf;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            authApi: AuthApi(dio: dio),
            authLocalDatasource: AuthLocalDatasource(sf),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userApi: UserApi(
              dio: dio,
            ),
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
            create: (context) => UserBloc(
              userRepository: context.read<UserRepository>(),
            ),
          ),
        ],
        child: AppContent(sf: sf),
      ),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({super.key, required this.sf});
  final SharedPreferences sf;

  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthAuthenticateStarted());
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AuthBloc>().state;
    if (state is AuthInitial) {
      return Container();
    }
    if (state is AuthAuthenticateSuccess) {
      print('accessToken: ${state.accessToken}');
      context.read<UserBloc>().add(UserFetched(state.accessToken));
    }

    return ScreenUtilInit(
      designSize: const Size(430, 932),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
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
  @override
  Set<PointerDeviceKind> get dragDevices =>
      {PointerDeviceKind.touch, PointerDeviceKind.mouse};
}
