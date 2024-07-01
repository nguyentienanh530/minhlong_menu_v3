import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/features/auth/bloc/auth_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/auth/view/screens/forgot_password_screen.dart';
import 'package:minhlong_menu_admin_v3/features/auth/view/screens/login_screen.dart';
import 'package:minhlong_menu_admin_v3/features/home/view/screens/home_screen.dart';

class AppRoute {
  AppRoute._();
  static const String home = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String signUp = '/sign-up';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String foods = '/foods';
  static const String tables = '/tables';
  static const String categories = '/categories';
  static const String banners = '/banners';
  static const String setting = '/setting';

  static const publicRoute = [login, forgotPassword, signUp];

  static GoRouter routes = GoRouter(
      initialLocation: home,
      redirect: (context, state) {
        if (publicRoute.contains(state.fullPath)) {
          return null;
        }
        if (context.read<AuthBloc>().state is AuthAuthenticateSuccess) {
          return null;
        }
        return login;
      },
      routes: [
        GoRoute(
          path: home,
          builder: (context, state) {
            return const HomeScreen();
          },
        ),
        GoRoute(
          path: forgotPassword,
          builder: (context, state) {
            return const ForgotPasswordScreen();
          },
        ),
        GoRoute(
          path: login,
          builder: (context, state) {
            return const LoginScreen();
          },
        ),
      ]);
}
