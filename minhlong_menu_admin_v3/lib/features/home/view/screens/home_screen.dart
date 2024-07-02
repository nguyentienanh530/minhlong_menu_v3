import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../dinner_table/cubit/dinner_table_cubit.dart';
import '../../cubit/table_index_selected_cubit.dart';
import 'home_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    var index = context.watch<TableIndexSelectedCubit>().state;
    return BlocProvider(
      create: (context) => DinnerTableCubit(),
      child: HomeView(
        index: index,
        child: child,
      ),
    );
  }
}
