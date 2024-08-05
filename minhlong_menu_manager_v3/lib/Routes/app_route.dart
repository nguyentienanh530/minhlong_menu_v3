import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../features/auth/bloc/auth_bloc.dart';
import '../features/auth/view/screens/forgot_password_screen.dart';
import '../features/auth/view/screens/login_screen.dart';
import '../features/home/view/screens/home_screen.dart';

class AppRoute {
  AppRoute._();
  static const String home = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String signUp = '/sign-up';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String foods = '/foods';
  static const String dinnerTables = '/dinner-tables';
  static const String categories = '/categories';
  static const String banners = '/banners';
  static const String settings = '/settings';
  static const String orders = '/orders';
  static const String ordersHistory = '/orders-history';
  static const String updatePassword = '/update-password';
  static const String editProfile = '/edit-profile';
  static const String printScreen = '/print-screen';
  static const String loadScreen = '/load-screen';
  static const String createOrUpdateOrder = '/create-or-update-order';

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
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const HomeScreen(),
          );
        },
      ),
      GoRoute(
        path: forgotPassword,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const ForgotPasswordScreen(),
          );
        },
      ),
      GoRoute(
        path: login,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const LoginScreen(),
          );
        },
      ),
    ],
  );
}

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<T>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(
      opacity: animation,
      child: child,
    ),
  );
}
