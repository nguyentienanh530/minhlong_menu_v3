import 'dart:convert';
import 'package:badges/badges.dart' as badges;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/Routes/app_route.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_admin_v3/common/network/web_socket_manager.dart';
import 'package:minhlong_menu_admin_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_admin_v3/common/widget/common_icon_button.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_enum.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/pagination_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';
import 'package:minhlong_menu_admin_v3/features/user/data/model/user_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../common/widget/empty_widget.dart';
import '../../../../common/widget/error_build_image.dart';
import '../../../../core/api_config.dart';
import '../../../dinner_table/data/model/table_item.dart';
import '../../../home/cubit/table_index_selected_cubit.dart';
import '../../bloc/order_bloc.dart';
import '../../data/model/order_item.dart';
import '../../data/repositories/order_repository.dart';
part '../dialogs/_order_detail_dialog.dart';
part '../widgets/_order_header_widget.dart';
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
          create: (context) => TableIndexSelectedCubit(),
        ),
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
  final _webSocketManager = WebSocketManager();
  final _indexSelectedTable = ValueNotifier(0);
  var _isFirstSendSocket = false;
  List<TableItem> dinnerTable = <TableItem>[];
  late UserModel _user;

  List<OrderItem> ordersList = <OrderItem>[];
  final _curentPage = ValueNotifier(1);
  final _limit = ValueNotifier(10);
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _user = widget.user;

    _webSocketManager.sendSocket('tables', 'tables', _user.id);
    _webSocketManager
        .sendSocket('orders', 'orders', {'user_id': _user.id, 'table_id': 0});
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _curentPage.dispose();
    _limit.dispose();
    _indexSelectedTable.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final tableIndexSelectedState =
        context.watch<TableIndexSelectedCubit>().state;
    print('tableIndexSelectedState: $tableIndexSelectedState');
    if (!_isFirstSendSocket) {
      // Ultils.joinRoom(_orderChannel, 'orders-${_user.id}');
      // Ultils.joinRoom(_tableChannel, 'tables-${_user.id}');

      _isFirstSendSocket = true;
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderUpdateStatusInProgress ||
                state is OrderPaymentInProgress ||
                state is OrderDeleted) {
              AppDialog.showLoadingDialog(context);
            }
            if (state is OrderUpdateStatusSuccess ||
                state is OrderDeleteSuccess) {
              pop(context, 1);
              OverlaySnackbar.show(context, 'Cập nhật thành công');
              // Ultils.sendSocket(_orderChannel, 'orders',
              //     {'user_id': _user.id, 'table_id': tableIndexSelectedState});
              // Ultils.sendSocket(_tableChannel, 'tables', _user.id);
            }
            if (state is OrderPaymentSuccess) {
              pop(context, 2);
              OverlaySnackbar.show(context, 'Cập nhật thành công');
              // Ultils.sendSocket(_orderChannel, 'orders',
              //     {'user_id': _user.id, 'table_id': tableIndexSelectedState});
              // Ultils.sendSocket(_tableChannel, 'tables', _user.id);
            }

            if (state is OrderUpdateStatusFailure) {
              pop(context, 1);
              OverlaySnackbar.show(context, 'Có lỗi xảy ra',
                  type: OverlaySnackbarType.error);
            }

            if (state is OrderPaymentFailure) {
              pop(context, 1);
              OverlaySnackbar.show(context, 'Có lỗi xảy ra',
                  type: OverlaySnackbarType.error);
            }

            if (state is OrderDeleteFailure) {
              pop(context, 1);
              OverlaySnackbar.show(context, 'Có lỗi xảy ra',
                  type: OverlaySnackbarType.error);
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _orderHeaderWidget(tableIndexSelectedState, ordersList),
              16.verticalSpace,
              _buildTablesWidget(index: tableIndexSelectedState),
              16.verticalSpace,
              Expanded(
                  child: SingleChildScrollView(
                      child: _buildOrdersOnTable(tableIndexSelectedState))),
            ],
          ),
        ),
      ),
    );
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
        return Colors.red;
      case 'processing':
        return Colors.blue;
      case 'completed':
        return Colors.green;
      case 'cancel':
        return Colors.red;

      default:
        return Colors.black;
    }
  }

  void _showDetailDialog(List<OrderItem> orders) {
    if (orders.isEmpty) {
      OverlaySnackbar.show(context, 'Không có đơn hàng',
          type: OverlaySnackbarType.error);
      return;
    }
    var listID = orders.map((e) => e.id).toList();

    showDialog(
      context: context,
      builder: (context) =>
          _orderDetailDialog(_mergeOrderItems(orders), listID),
    );
  }

  OrderItem _mergeOrderItems(List<OrderItem> orderItems) {
    orderItems.sort((a, b) => a.createdAt!.compareTo(b.createdAt!));

    OrderItem mergedOrders = OrderItem(
        createdAt: orderItems[0].createdAt,
        tableId: orderItems[0].tableId,
        tableName: orderItems[0].tableName,
        foodOrders: []);

    List<FoodOrderModel> mergedFoodOrders = [];
    for (OrderItem orderItem in orderItems) {
      mergedFoodOrders.addAll(orderItem.foodOrders);
    }

    Map<int, FoodOrderModel> groupedOrders = {};

    for (FoodOrderModel foodOrder in mergedFoodOrders) {
      if (groupedOrders.containsKey(foodOrder.foodID)) {
        groupedOrders[foodOrder.foodID] =
            groupedOrders[foodOrder.foodID]!.copyWith(
          quantity:
              groupedOrders[foodOrder.foodID]!.quantity + foodOrder.quantity,
          totalAmount: groupedOrders[foodOrder.foodID]!.totalAmount +
              foodOrder.totalAmount,
        );
      } else {
        groupedOrders[foodOrder.foodID] = FoodOrderModel(
          id: foodOrder.id,
          name: foodOrder.name,
          foodID: foodOrder.foodID,
          image1: foodOrder.image1,
          price: foodOrder.price,
          quantity: foodOrder.quantity,
          totalAmount: foodOrder.totalAmount,
          isDiscount: foodOrder.isDiscount,
          discount: foodOrder.discount,
        );
      }
    }

    List<FoodOrderModel> groupedFoodOrders = groupedOrders.values.toList();
    var totalPrice = groupedFoodOrders.fold(
      0.0,
      (previousValue, element) => previousValue + element.totalAmount,
    );
    mergedOrders = mergedOrders.copyWith(
        status: 'completed',
        foodOrders: groupedFoodOrders,
        totalPrice: totalPrice);

    return mergedOrders;
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
