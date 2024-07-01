import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/Routes/app_route.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_dialog.dart';

import '../../../auth/bloc/auth_bloc.dart';
import '../widgets/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
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
                        });
                  },
                );
                break;
              default:
            }
          },
          child: SideMenuWidget()
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     // const Text('Home Screen'),
          //     // FilledButton(
          //     //   onPressed: () {
          //     //     context.read<AuthBloc>().add(AuthLogoutStarted());
          //     //   },
          //     //   child: const Text('Logout'),
          //     // ),

          //   ],
          // ),
          ),
    );
  }
}
