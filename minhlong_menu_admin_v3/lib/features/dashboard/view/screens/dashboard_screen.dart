import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/cubit/dinner_table_cubit.dart';
import 'package:badges/badges.dart' as badges;
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_model.dart';
import 'package:minhlong_menu_admin_v3/features/home/cubit/table_index_selected_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/order_socket_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/web_socket_client/cubit/web_socket_client_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../../core/utils.dart';
import '../../../order/data/model/order_model.dart';

part '../widgets/_table_widget.dart';
part '../widgets/_orders_on_table_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildDesktopScreen();
  }

  Widget _buildMobileScreen() {
    return const SizedBox();
  }

  Widget _buildTabletScreen() {
    return const SizedBox();
  }

  Widget _buildDesktopScreen() {
    return Scaffold(
      body: BlocBuilder<TableIndexSelectedCubit, int>(
        builder: (context, state) {
          final dinnerTable = context.watch<DinnerTableCubit>().state;
          final orders = context.watch<OrderSocketCubit>().state;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              _buildTableWidget(index: state, dinnerTable: dinnerTable),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildOrdersOnTable(orders),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
