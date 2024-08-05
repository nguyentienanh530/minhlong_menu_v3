import 'package:device_preview/device_preview.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:minhlong_menu_manager_v3/Routes/app_route.dart';
import 'package:minhlong_menu_manager_v3/features/auth/bloc/auth_bloc.dart';
import 'package:minhlong_menu_manager_v3/features/auth/data/auth_local_datasource/auth_local_datasource.dart';
import 'package:minhlong_menu_manager_v3/features/auth/data/provider/remote/auth_api.dart';
import 'package:minhlong_menu_manager_v3/features/auth/data/repositories/auth_repository.dart';
import 'package:minhlong_menu_manager_v3/features/user/cubit/user_cubit.dart';
import 'package:minhlong_menu_manager_v3/features/user/data/user_local_datasource/user_local_datasource.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bloc_observer.dart';
import 'common/network/dio_client.dart';
import 'common/network/dio_interceptor.dart';
import 'features/auth/data/model/access_token.dart';
import 'features/user/bloc/search_user_bloc/search_user_bloc.dart';
import 'features/user/bloc/user_bloc/user_bloc.dart';
import 'features/user/data/provider/user_api.dart';
import 'features/user/data/repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();
  final sf = await SharedPreferences.getInstance();
  dio.interceptors.add(DioInterceptor(sf));

  runApp(DevicePreview(enabled: false, builder: (context) => MainApp(sf: sf)));
}

class MainApp extends StatelessWidget {
  const MainApp({
    super.key,
    required this.sf,
  });

  final SharedPreferences sf;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
              authApi: AuthApi(dio: dio),
              authLocalDatasource: AuthLocalDatasource(sf),
              userLocalDatasource: UserLocalDatasource(sf)),
        ),
        RepositoryProvider(
          create: (context) => UserRepo(
            userLocalDatasource: UserLocalDatasource(sf),
            userApi: UserApi(
              dio: dio,
            ),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider(
            create: (context) => UserBloc(
              userRepository: context.read<UserRepo>(),
            ),
          ),
          BlocProvider(
            create: (context) => UserCubit(),
          ),
          BlocProvider(
            create: (context) => SearchUserBloc(context.read<UserRepo>()),
          ),
        ],
        child: AppContent(sf: sf),
      ),
    );
  }
}

class AppContent extends StatefulWidget {
  const AppContent({
    super.key,
    required this.sf,
  });

  final SharedPreferences sf;
  @override
  State<AppContent> createState() => _AppContentState();
}

class _AppContentState extends State<AppContent> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthAuthenticateStarted());

    super.initState();
  }

  void _handleGetUser(AccessToken accessToken) async {
    // check token is expired
    var hasExpired = JwtDecoder.isExpired(accessToken.accessToken);
    var hasExpiredRefresh = JwtDecoder.isExpired(accessToken.refreshToken);

    if (!hasExpired && !hasExpiredRefresh) {
      context.read<UserBloc>().add(UserFetched(accessToken));
    }
    if (hasExpiredRefresh) {
      await AuthLocalDatasource(widget.sf).removeAccessToken();
      if (!mounted) return;
      context.read<AuthBloc>().add(AuthAuthenticateStarted());
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
    final state = context.watch<AuthBloc>().state;

    if (state is AuthInitial) {
      return Container();
    }
    if (state is AuthAuthenticateSuccess) {
      _handleGetUser(state.accessToken);
    }

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthRefreshTokenSuccess) {
          context.read<AuthBloc>().add(AuthAuthenticateStarted());
          context.read<UserBloc>().add(UserFetched(state.accessToken));
        }
        if (state is AuthRefreshTokenFailure) {
          await AuthLocalDatasource(widget.sf).removeAccessToken();
          if (!context.mounted) return;
          context.read<AuthBloc>().add(AuthAuthenticateStarted());
        }
      },
      child: ScreenUtilInit(
        designSize: const Size(1920, 1024),
        minTextAdapt: true,
        splitScreenMode: true,
        // Use builder only if you need to use library outside ScreenUtilInit context
        builder: (_, child) {
          return MaterialApp.router(
            title: 'Minh Long Menu',
            debugShowCheckedModeBanner: false,
            routerConfig: AppRoute.routes,
            scrollBehavior: MyCustomScrollBehavior(),
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate
            ],
            supportedLocales: const [Locale('en'), Locale('vi')],
          );
        },
      ),
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
