import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/no_product.dart';
import 'package:minhlong_menu_client_v3/features/auth/view/screens/forgot_password_screen.dart';
import 'package:minhlong_menu_client_v3/features/auth/view/screens/login_screen.dart';
import 'package:minhlong_menu_client_v3/features/cart/view/screen/cart_screen.dart';
import 'package:minhlong_menu_client_v3/features/category/view/screen/category_screen.dart';
import 'package:minhlong_menu_client_v3/features/home/view/screens/home_screen.dart';
import 'package:minhlong_menu_client_v3/features/profile/view/screen/edit_profile_screen.dart';
import 'package:minhlong_menu_client_v3/features/profile/view/screen/profile_screen.dart';
import 'package:minhlong_menu_client_v3/features/table/view/screen/table_screen.dart';

import '../features/food/data/model/food_model.dart';
import '../features/food/view/screen/food_detail_screen.dart';

class AppRoute {
  AppRoute._();
  static const String home = '/';
  static const String login = '/login';
  static const String forgotPassword = '/forgot-password';
  static const String signUp = '/sign-up';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String foods = '/foods';
  static const String carts = '/carts';
  static const String foodsDetail = '/foods-detail';
  static const String dinnerTables = '/dinner-tables';
  static const String categories = '/categories';
  static const String banners = '/banners';
  static const String profile = '/profile';
  static const String editProfile = '/edit-profile';
  static const String noProductPage = '/no-product-page';

  static const publicRoute = [login, forgotPassword, signUp];

  static GoRouter routes = GoRouter(
    initialLocation: home,
    // redirect: (context, state) {
    //   if (publicRoute.contains(state.fullPath)) {
    //     return null;
    //   }
    //   if (context.read<AuthBloc>().state is AuthAuthenticateSuccess) {
    //     return null;
    //   }
    //   return foods;
    // },
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
      GoRoute(
        path: foodsDetail,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: FoodDetailScreen(
              foodModel: state.extra as FoodModel,
            ),
          );
        },
      ),
      GoRoute(
        path: carts,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const CartScreen(),
          );
        },
      ),
      GoRoute(
        path: categories,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: CategoryScreen(),
          );
        },
      ),
      GoRoute(
        path: dinnerTables,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const TableScreen(),
          );
        },
      ),
      GoRoute(
        path: profile,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const ProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: editProfile,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const EditProfileScreen(),
          );
        },
      ),
      GoRoute(
        path: noProductPage,
        pageBuilder: (context, state) {
          return buildPageWithDefaultTransition(
            context: context,
            state: state,
            child: const NoProduct(),
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
