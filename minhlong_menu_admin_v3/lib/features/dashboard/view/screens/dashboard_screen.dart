import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:minhlong_menu_admin_v3/common/network/dio_client.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:badges/badges.dart' as badges;
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/info_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/model/info_model.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/provider/info_api.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_model.dart';
import 'package:minhlong_menu_admin_v3/features/home/cubit/table_index_selected_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/order_socket_cubit.dart';
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
part '../widgets/_info_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => InfoRespository(InfoApi(DioClient().dio!)),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TableIndexSelectedCubit(),
          ),
          BlocProvider(
            create: (context) => DinnerTableCubit(),
          ),
          BlocProvider(
            create: (context) => InfoBloc(context.read<InfoRespository>())
              ..add(InfoFetchStarted()),
          )
        ],
        child: const DashboardView(),
      ),
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
    return Scaffold(
      body: BlocBuilder<TableIndexSelectedCubit, int>(
        builder: (context, state) {
          final dinnerTable = context.watch<DinnerTableCubit>().state;
          final orders = context.watch<OrderSocketCubit>().state;

          return Padding(
            padding: const EdgeInsets.all(30).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTableWidget(index: state, dinnerTable: dinnerTable),
                const SizedBox(height: defaultPadding),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: SingleChildScrollView(
                              child: _buildOrdersOnTable(orders))),
                      context.isDesktop
                          ? Container(
                              padding: const EdgeInsets.only(left: 30).r,
                              width: 450.w,
                              height: double.infinity,
                              child: Column(
                                children: [
                                  _buildInfoWidget(),
                                ],
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
