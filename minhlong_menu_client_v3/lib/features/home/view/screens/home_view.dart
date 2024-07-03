import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Routes/app_route.dart';
import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/error_dialog.dart';
import '../../../auth/bloc/auth_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        switch (state) {
          case AuthLogoutSuccess():
            context.read<AuthBloc>().add(AuthEventStarted());
            context.pushReplacement(AppRoute.login);

            break;
          case AuthLogoutFailure(message: final msg):
            showDialog(
              context: context,
              builder: (context) {
                return ErrorDialog(
                  title: msg,
                  onRetryText: 'Thử lại',
                  onRetryPressed: () {
                    context.pop();
                    context.read<AuthBloc>().add(AuthLogoutStarted());
                  },
                );
              },
            );
            break;
          default:
        }
      },
      child: Scaffold(
          body: Center(
        child: TextButton(
            onPressed: () => _showDialogLogout(), child: const Text('Logout')),
      )),
    );
  }

  void _showDialogLogout() {
    showDialog(
        context: context,
        builder: (context) {
          return AppDialog(
            title: 'Đăng xuất?',
            description: 'Bạn có muốn đăng xuất?',
            onTap: () {
              context.read<AuthBloc>().add(AuthLogoutStarted());
            },
          );
        });
  }
}
