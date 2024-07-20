import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';

import 'package:minhlong_menu_admin_v3/common/widget/empty_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:badges/badges.dart' as badges;
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/info_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/model/info_model.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/view/widgets/line_chart_revenue.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';
import 'package:minhlong_menu_admin_v3/features/home/cubit/table_index_selected_cubit.dart';

import 'package:minhlong_menu_admin_v3/features/user/bloc/user_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../common/snackbar/overlay_snackbar.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
import '../../../../core/utils.dart';
import '../../../dinner_table/cubit/dinner_table_cubit.dart';
import '../../../order/bloc/order_bloc.dart';
import '../../../order/data/model/order_item.dart';
import '../widgets/chart_revenue.dart';

part '../widgets/_table_widget.dart';
part '../widgets/_orders_on_table_widget.dart';
part '../widgets/_info_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen(
      {super.key, required this.userModel, required this.accessToken});
  final UserModel userModel;
  final String accessToken;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => TableIndexSelectedCubit(),
        ),
        BlocProvider(
          create: (context) => DinnerTableCubit(),
        ),
        BlocProvider(
          create: (context) => InfoBloc(context.read<InfoRespository>()),
        )
      ],
      child: DashboardView(
        userModel: userModel,
        accessToken: accessToken,
      ),
    );
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView(
      {super.key, required this.userModel, required this.accessToken});
  final UserModel userModel;
  final String accessToken;

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with AutomaticKeepAliveClientMixin {
  late final WebSocketChannel _tableChannel;
  late final WebSocketChannel _orderChannel;
  final _indexSelectedTable = ValueNotifier(0);
  var _isFirstSendSocket = false;
  late UserModel _user;
  @override
  void initState() {
    super.initState();
    _tableChannel = IOWebSocketChannel.connect(
        Uri.parse(ApiConfig.tablesSocketUrl),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
        })
      ..ready;
    _orderChannel = IOWebSocketChannel.connect(
        Uri.parse(ApiConfig.ordersSocketUrl),
        headers: {
          'Authorization': 'Bearer ${widget.accessToken}',
        })
      ..ready;
    context.read<InfoBloc>().add(InfoFetchStarted());
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
    _indexSelectedTable.dispose();
  }

  void disconnect() {
    if (_tableChannel.closeCode != null || _tableChannel.closeCode != null) {
      debugPrint('Not connected');
      return;
    }
    Ultils.leaveRoom(_tableChannel, 'tables-${_user.id}');
    Ultils.leaveRoom(_orderChannel, 'orders-${_user.id}');
    _tableChannel.sink.close();
    _orderChannel.sink.close();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final user = context.watch<UserBloc>().state;
    final tableIndexSelectedState =
        context.watch<TableIndexSelectedCubit>().state;
    if (user is UserFecthSuccess) {
      _user = user.userModel;
      if (!_isFirstSendSocket) {
        Ultils.joinRoom(_orderChannel, 'orders-${_user.id}');
        Ultils.joinRoom(_tableChannel, 'tables-${_user.id}');

        Ultils.sendSocket(_tableChannel, 'tables', _user.id);
        Ultils.sendSocket(_orderChannel, 'orders',
            {'user_id': _user.id, 'table_id': tableIndexSelectedState});

        _isFirstSendSocket = true;
      }
    }
    return Scaffold(
      body: BlocListener<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderUpdateInProgress) {
            AppDialog.showLoadingDialog(context);
          }
          if (state is OrderUpdateSuccess) {
            pop(context, 1);
            OverlaySnackbar.show(context, 'Cập nhật thành công');
            Ultils.sendSocket(_orderChannel, 'orders',
                {'user_id': _user.id, 'table_id': tableIndexSelectedState});
            Ultils.sendSocket(_tableChannel, 'tables', _user.id);
          }

          if (state is OrderUpdateFailure) {
            pop(context, 1);
            OverlaySnackbar.show(context, 'Có lỗi xảy ra',
                type: OverlaySnackbarType.error);
          }
        },
        child: SizedBox(
          height: context.sizeDevice.height,
          width: context.sizeDevice.width,
          child: Padding(
            padding: const EdgeInsets.all(30).r,
            child: SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    SizedBox(
                      height: 0.2 * context.sizeDevice.height,
                      width: double.infinity,
                      child: _buildInfoWidget(),
                    ),
                    15.verticalSpace,
                    SizedBox(
                      height: 0.5 * context.sizeDevice.height,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: _lineChartRevenueWidget(),
                          ),
                          15.horizontalSpace,
                          Expanded(
                            child: _chartRevenueWidget(),
                          )
                        ],
                      ),
                    ),
                    Card(
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(defaultPadding).r,
                        // constraints: const BoxConstraints(minHeight: 500),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Đơn hàng mới',
                              style: kHeadingStyle.copyWith(
                                  fontWeight: FontWeight.w700),
                            ),
                            const SizedBox(height: defaultPadding),
                            _buildTablesWidget(index: tableIndexSelectedState),
                            const SizedBox(height: defaultPadding),
                            _buildOrdersOnTable(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // child: Row(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     Expanded(
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           // _buildTableWidget(index: state, dinnerTable: dinnerTable),
            //           _buildTablesWidget(index: tableIndexSelectedState),
            //           const SizedBox(height: defaultPadding),
            //           Expanded(
            //             child: SingleChildScrollView(
            //               child: _buildOrdersOnTable(),
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //     context.isDesktop
            //         ? Container(
            //             padding: const EdgeInsets.only(left: 30).r,
            //             width: 450.w,
            //             height: double.infinity,
            //             child: SingleChildScrollView(
            //               child: Column(
            //                 children: [
            //                   _buildInfoWidget(),
            //                   const SizedBox(height: defaultPadding),
            //                   _lineChartRevenueWidget(),
            //                   const SizedBox(height: defaultPadding),
            //                   _chartRevenueWidget()
            //                 ],
            //               ),
            //             ),
            //           )
            //         : Container(),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }

  Widget _lineChartRevenueWidget() {
    return Card(
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Doanh thu',
                      style: kSubHeadingStyle.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Row(
                      children: [
                        // Text(
                        //     Ultils().formatDateToString(
                        //         controller.date.value.toString(),
                        //         isShort: true),
                        //     style: kBodyStyle),
                        SizedBox(
                          width: defaultPadding / 2,
                        ),
                        // DropdownButton(
                        //   items: controller.listDateDropdown
                        //       .map(
                        //           (e) => DropdownMenuItem(value: e, child: Text(e)))
                        //       .toList(),
                        //   onChanged: (value) {
                        //     controller.onChangeDateDropDown(value ?? '');
                        //   },
                        //   isDense: true,
                        //   underline: Container(),
                        //   value: controller.valueDateDropDown.value,
                        //   icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        //   dropdownColor: AppColors.white,
                        //   style: kBodyStyle,
                        //   focusColor: AppColors.white,
                        //   borderRadius: BorderRadius.circular(5),
                        //   menuMaxHeight: 300,
                        //   alignment: Alignment.center,
                        //   iconSize: 20,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Text(
                  Ultils.currencyFormat(double.parse('500000000')),
                  style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.themeColor,
                  ),
                ),
              ),
              10.verticalSpace,
              const Expanded(
                flex: 8,
                child: LineChartRevenue(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chartRevenueWidget() {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Doanh thu',
                  style: kSubHeadingStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                // Obx(
                //   () {
                //     return DropdownButton(
                //       items: controller.listDateDropdown
                //           .map(
                //               (e) => DropdownMenuItem(value: e, child: Text(e)))
                //           .toList(),
                //       onChanged: (value) {
                //         controller.valueDateDropDown.value = value!;
                //       },
                //       isDense: true,
                //       underline: Container(),
                //       value: controller.valueDateDropDown.value,
                //       icon: const Icon(Icons.keyboard_arrow_down_rounded),
                //       dropdownColor: AppColors.white,
                //       style: kBodyStyle,
                //       focusColor: AppColors.white,
                //       borderRadius: BorderRadius.circular(5),
                //       menuMaxHeight: 300,
                //       alignment: Alignment.center,
                //       iconSize: 20,
                //     );
                //   },
                // ),
              ],
            ),
            const SizedBox(
              height: defaultPadding / 2,
            ),
            Text(
              Ultils.currencyFormat(double.parse('500000000')),
              style: kBodyStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.themeColor,
              ),
            ),
            const Expanded(
              child: PieChartSample2(),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
