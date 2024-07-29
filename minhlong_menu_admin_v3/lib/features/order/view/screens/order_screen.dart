import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/Routes/app_route.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_admin_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_admin_v3/common/widget/common_icon_button.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_enum.dart';
import 'package:minhlong_menu_admin_v3/core/app_style.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/pagination_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../common/widget/number_pagination.dart';
import '../../../../core/api_config.dart';
import '../../../../core/const_res.dart';
import '../../../dinner_table/data/model/table_item.dart';
import '../../../home/cubit/table_index_selected_cubit.dart';
import '../../bloc/order_bloc.dart';
import '../../data/model/order_item.dart';
import '../../data/model/order_model.dart';
import '../../data/repositories/order_repository.dart';
import 'package:badges/badges.dart' as badges;
part '../widgets/_order_header_widget.dart';
part '../widgets/_order_body_widget.dart';
part '../dialogs/_order_detail_dialog.dart';
part '../widgets/_orders_on_table_widget.dart';
part '../widgets/_table_widget.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => OrderBloc(context.read<OrderRepository>())),
        BlocProvider(
          create: (context) => PaginationCubit(),
        ),
      ],
      child: OrderView(user: user),
    );
  }
}

class OrderView extends StatefulWidget {
  const OrderView({super.key, required this.user});
  final UserModel user;

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late final WebSocketChannel _tableChannel;
  late final WebSocketChannel _orderChannel;
  final _indexSelectedTable = ValueNotifier(0);
  var _isFirstSendSocket = false;
  var _ordersLength = 0;
  late UserModel _user;
  final _orderModel = ValueNotifier(OrderModel());
  final _listTitleTable = [
    'ID',
    'Ngày',
    'Bàn',
    'SL món',
    'T.Tiền',
    'T.Thái',
    'H.Động'
  ];
  final _curentPage = ValueNotifier(1);
  final _limit = ValueNotifier(10);
  late final TabController _tabController;
  final _listStatus = ['new', 'processing'];

  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _tabController = TabController(length: 2, vsync: this);
    _tableChannel = IOWebSocketChannel.connect(
        Uri.parse(ApiConfig.tablesSocketUrl),
        headers: {
          ConstRes.userID: '${_user.id}',
        })
      ..ready;
    _orderChannel = IOWebSocketChannel.connect(
        Uri.parse(ApiConfig.ordersSocketUrl),
        headers: {
          ConstRes.userID: '${_user.id}',
        })
      ..ready;
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
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _orderModel.dispose();
    _curentPage.dispose();
    _limit.dispose();
    disconnect();
    _indexSelectedTable.dispose();
  }

  // Ultils.joinRoom(_tableChannel, 'tables-${_user.id}');
  // Ultils.joinRoom(_orderChannel, 'orders-${_user.id}');
  // Ultils.sendSocket(_tableChannel, 'tables', _user.id);
  // Ultils.sendSocket(_orderChannel, 'orders',
  //     {'user_id': _user.id, 'table_id': tableIndexSelectedState});

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final tableIndexSelectedState =
        context.watch<TableIndexSelectedCubit>().state;

    if (!_isFirstSendSocket) {
      Ultils.joinRoom(_orderChannel, 'orders-${_user.id}');
      Ultils.joinRoom(_tableChannel, 'tables-${_user.id}');

      Ultils.sendSocket(_tableChannel, 'tables', _user.id);
      Ultils.sendSocket(_orderChannel, 'orders',
          {'user_id': _user.id, 'table_id': tableIndexSelectedState});

      _isFirstSendSocket = true;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderUpdateStatusInProgress) {
              AppDialog.showLoadingDialog(context);
            }
            if (state is OrderUpdateStatusSuccess) {
              pop(context, 1);
              OverlaySnackbar.show(context, 'Cập nhật thành công');
              Ultils.sendSocket(_orderChannel, 'orders',
                  {'user_id': _user.id, 'table_id': tableIndexSelectedState});
              Ultils.sendSocket(_tableChannel, 'tables', _user.id);
            }

            if (state is OrderUpdateStatusFailure) {
              pop(context, 1);
              OverlaySnackbar.show(context, 'Có lỗi xảy ra',
                  type: OverlaySnackbarType.error);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _orderHeaderWidget(tableIndexSelectedState),
              10.verticalSpace,
              const SizedBox(height: defaultPadding),
              _buildTablesWidget(index: tableIndexSelectedState),
              const SizedBox(height: defaultPadding),
              Expanded(
                child: SingleChildScrollView(
                    child: _buildOrdersOnTable(tableIndexSelectedState)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _fetchData(
      {required String status, required int page, required int limit}) {
    context.read<OrderBloc>().add(
        OrderFetchNewOrdersStarted(status: status, page: page, limit: limit));
  }

  String _handleStatus(String status) {
    switch (status) {
      case 'new':
        return 'Đơn mới';
      case 'processing':
        return 'Đang làm';
      case 'completed':
        return 'Hoàn thành';
      case 'cancel':
        return 'Đã huỷ';

      default:
        return 'Đã đặt';
    }
  }

  Color _handleColor(String status) {
    switch (status) {
      case 'new':
        return AppColors.red;
      case 'processing':
        return AppColors.blue;
      case 'completed':
        return AppColors.islamicGreen;
      case 'cancel':
        return AppColors.red;

      default:
        return AppColors.black;
    }
  }

  void _showDetailDialog(OrderItem orderItem) {
    showDialog(
      context: context,
      builder: (context) => _orderDetailDialog(orderItem),
    );
  }

  void _handleUpdateOrder({required int orderID, required String status}) {
    context
        .read<OrderBloc>()
        .add(OrderStatusUpdated(orderID: orderID, status: status));
    context.pop();
  }

  _handleDeleteOrder({required int orderID}) {
    context.read<OrderBloc>().add(OrderDeleted(id: orderID));
  }

  @override
  bool get wantKeepAlive => true;
}
