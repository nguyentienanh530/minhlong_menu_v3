import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/features/auth/bloc/auth_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/auth/view/screens/forgot_password_screen.dart';
import 'package:minhlong_menu_admin_v3/features/auth/view/screens/login_screen.dart';
import 'package:minhlong_menu_admin_v3/features/banner/view/screens/banner_screen.dart';
import 'package:minhlong_menu_admin_v3/features/category/view/screens/category_screen.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/view/screens/dinner_table_screen.dart';
import 'package:minhlong_menu_admin_v3/features/food/view/screens/food_screen.dart';
import 'package:minhlong_menu_admin_v3/features/home/view/screens/home_screen.dart';

import 'package:minhlong_menu_admin_v3/features/order/data/model/order_item.dart';
import 'package:minhlong_menu_admin_v3/features/order/view/screens/order_screen.dart';
import 'package:minhlong_menu_admin_v3/features/print/view/screens/print_screen.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:minhlong_menu_admin_v3/features/user/view/widgets/change_password.dart';

import '../features/user/view/screens/edit_profile_screen.dart';

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
  static const String updatePassword = '/update-password';
  static const String editProfile = '/edit-profile';
  static const String printScreen = '/print-screen';
  static const String loadScreen = '/load-screen';

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
      // GoRoute(
      //   path: dashboard,
      //   pageBuilder: (context, state) {
      //     return buildPageWithDefaultTransition(
      //       context: context,
      //       state: state,
      //       child: const DashboardScreen(),
      //     );
      //   },
      // ),
      GoRoute(
        path: foods,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const FoodScreen(),
          );
        },
      ),
      GoRoute(
        path: orders,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const OrderScreen(),
          );
        },
      ),
      GoRoute(
        path: dinnerTables,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const DinnerTableScreen(),
          );
        },
      ),
      GoRoute(
        path: categories,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const CategoryScreen(),
          );
        },
      ),
      GoRoute(
        path: banners,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const BannerScreen(),
          );
        },
      ),
      GoRoute(
        path: editProfile,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: EditProfileScreen(
              user: state.extra as UserModel,
            ),
          );
        },
      ),
      GoRoute(
        path: updatePassword,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const ChangePassword(),
          );
        },
      ),
      GoRoute(
        path: printScreen,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: PrintScreen(order: state.extra as OrderItem),
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
