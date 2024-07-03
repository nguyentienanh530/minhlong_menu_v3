import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:badges/badges.dart' as badges;
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_model.dart';
import 'package:minhlong_menu_admin_v3/features/home/cubit/table_index_selected_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/order_socket_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/web_socket_client/cubit/web_socket_client_cubit.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../../core/utils.dart';
import '../../../dinner_table/cubit/dinner_table_cubit.dart';
import '../../../order/data/model/order_model.dart';

part '../widgets/_table_widget.dart';
part '../widgets/_orders_on_table_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TableIndexSelectedCubit(),
        ),
        BlocProvider(
          create: (context) => DinnerTableCubit(),
        )
      ],
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with AutomaticKeepAliveClientMixin {
  final WebSocketChannel _channel =
      WebSocketChannel.connect(Uri.parse(ApiConfig.webSocketUrl));
  final _indexSelectedTable = ValueNotifier(0);
  @override
  void initState() {
    _channel.ready.then((value) {
      _handleDataSocket(_indexSelectedTable.value);
      Ultils.sendSocket(_channel, 'tables', 0);
      Ultils.sendSocket(_channel, 'orders', 0);
    });
    super.initState();
  }

  @override
  void dispose() {
    disconnect();
    super.dispose();
  }

  void disconnect() {
    if (_channel.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    _channel.sink.close();
  }

  void _handleDataSocket(int tableIndexSelected) {
    _channel.stream.listen(
      (event) {
        Map<String, dynamic> data = jsonDecode(event);

        switch (data['event']) {
          case 'tables-ws':
            var res = jsonDecode(data['payload']);
            context.read<DinnerTableCubit>().setTableList(
                List<TableModel>.from(res.map((x) => TableModel.fromJson(x))));

            break;
          case 'orders-ws':
            var res = jsonDecode(data['payload']);

            var orderList = <OrderModel>[];
            var orders =
                List<OrderModel>.from(res.map((x) => OrderModel.fromJson(x)));

            if (tableIndexSelected != 0) {
              for (var order in orders) {
                if (order.tableId == tableIndexSelected) {
                  orderList.add(order);
                }
              }
            } else {
              orderList = orders;
            }
            context.read<OrderSocketCubit>().setOrderList(orderList);
            break;
          default:
            log('event: $event');
            break;
        }
      },
      onDone: () {
        log('Connection closed');
      },
      onError: (error) {
        log('Error: $error');
      },
    );

    // if (!mounted) return;
  }

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
                child:
                    SingleChildScrollView(child: _buildOrdersOnTable(orders)),
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
