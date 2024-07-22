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
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/best_selling_food/best_selling_food_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/data_chart/data_chart_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/bloc/info/info_bloc.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/model/info_model.dart';
import 'package:minhlong_menu_admin_v3/features/dashboard/data/respositories/info_respository.dart';
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
import '../../data/model/data_chart.dart';
import '../widgets/_column_revenue_chart.dart';
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
          create: (context) => InfoBloc(
            context.read<InfoRespository>(),
          ),
        ),
        BlocProvider(
          create: (context) => BestSellingFoodBloc(
            infoRespository: context.read<InfoRespository>(),
          ),
        ),
        BlocProvider(
          create: (context) => DataChartBloc(
            infoRespository: context.read<InfoRespository>(),
          ),
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
  final _listDateDropdown = ['Tuần này', 'Tháng này', 'Năm nay'];
  final _valueDropdown = ValueNotifier('');

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
    context.read<BestSellingFoodBloc>().add(BestSellingFoodFetched());
    context.read<DataChartBloc>().add(DataChartFetched('week'));
    _valueDropdown.value = _listDateDropdown.first;
  }

  void _getDataDashboard() {
    context.read<InfoBloc>().add(InfoFetchStarted());
    context.read<BestSellingFoodBloc>().add(BestSellingFoodFetched());
    context.read<DataChartBloc>().add(DataChartFetched('week'));
    Ultils.joinRoom(_tableChannel, 'tables-${_user.id}');
    Ultils.joinRoom(_orderChannel, 'orders-${_user.id}');
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
    _indexSelectedTable.dispose();
    _valueDropdown.dispose();
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
    final tableIndexSelectedState =
        context.watch<TableIndexSelectedCubit>().state;
    return BlocListener<OrderBloc, OrderState>(
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
      child: Builder(builder: (context) {
        final user = context.watch<UserBloc>().state;

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

        return Padding(
          padding: const EdgeInsets.all(30).r,
          child: RefreshIndicator(
            onRefresh: () async {
              _getDataDashboard();
            },
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: 180,
                    child: _buildInfoWidget(),
                  ),
                  15.verticalSpace,
                  context.isDesktop
                      ? SizedBox(
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
                                child: _chartBestSellingFoodWidget(),
                              )
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            SizedBox(
                                height: 0.5 * context.sizeDevice.height,
                                child: _lineChartRevenueWidget()),
                            15.horizontalSpace,
                            SizedBox(
                                height: 0.5 * context.sizeDevice.height,
                                child: _chartBestSellingFoodWidget())
                          ],
                        ),
                  15.verticalSpace,
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
        );
      }),
    );
  }

  Widget _lineChartRevenueWidget() {
    return Card(
      child: Builder(builder: (context) {
        var dataChartState = context.watch<DataChartBloc>().state;
        return (switch (dataChartState) {
          DataChartFetchInProgress() => const Loading(),
          DataChartFetchEmpty() => const EmptyWidget(),
          DataChartFetchFailure() => ErrWidget(error: dataChartState.message),
          DataChartFetchSuccess() =>
            _buildChartRevenueFetchSuccess(dataChartState.dataCharts),
          _ => const SizedBox(),
        });
      }),
    );
  }

  Widget _buildChartRevenueFetchSuccess(List<DataChart> dataCharts) {
    return Padding(
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
                ListenableBuilder(
                    listenable: _valueDropdown,
                    builder: (context, _) {
                      return DropdownButton(
                        items: _listDateDropdown
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (value) {
                          switch (value) {
                            case 'Tuần này':
                              context
                                  .read<DataChartBloc>()
                                  .add(DataChartFetched('week'));
                              break;
                            case 'Tháng này':
                              context
                                  .read<DataChartBloc>()
                                  .add(DataChartFetched('month'));
                              break;
                            case 'Năm nay':
                              context
                                  .read<DataChartBloc>()
                                  .add(DataChartFetched('year'));
                              break;
                            default:
                          }
                          _valueDropdown.value = value!;
                        },
                        isDense: true,
                        underline: Container(),
                        value: _valueDropdown.value,
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        dropdownColor: AppColors.white,
                        style: kBodyStyle,
                        focusColor: AppColors.white,
                        borderRadius: BorderRadius.circular(5),
                        menuMaxHeight: 300,
                        alignment: Alignment.center,
                        iconSize: 20,
                      );
                    }),
              ],
            ),
          ),
          10.verticalSpace,
          Expanded(
            flex: 8,
            child: ColumnRevenueChart(
              dataCharts: dataCharts,
            ),
          ),
        ],
      ),
    );
  }

  Widget _chartBestSellingFoodWidget() {
    return Builder(builder: (context) {
      var bestSellingFoodState = context.watch<BestSellingFoodBloc>().state;
      return (switch (bestSellingFoodState) {
        BestSellingFoodFetchInProgress() => const Loading(),
        BestSellingFoodFetchEmpty() => const EmptyWidget(),
        BestSellingFoodFetchFailure() =>
          ErrWidget(error: bestSellingFoodState.message),
        BestSellingFoodFetchSuccess() => Card(
            child: Container(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bán chạy',
                    style:
                        kSubHeadingStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: PieChartBestSellingFood(
                      bestSellingFood: bestSellingFoodState.bestSellingFoods,
                    ),
                  ),
                ],
              ),
            ),
          ),
        _ => const SizedBox(),
      });
    });
  }

  @override
  bool get wantKeepAlive => true;
}
