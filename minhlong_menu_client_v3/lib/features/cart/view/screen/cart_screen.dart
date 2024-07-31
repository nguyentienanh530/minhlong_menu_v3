import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_icon_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/error_build_image.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/core/app_const.dart';
import 'package:minhlong_menu_client_v3/core/const_res.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/cart/cubit/cart_cubit.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_detail.dart';
import 'package:minhlong_menu_client_v3/features/order/data/model/order_model.dart';
import 'package:minhlong_menu_client_v3/features/order/data/repositories/order_repository.dart';
import 'package:minhlong_menu_client_v3/features/table/cubit/table_cubit.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../../../../Routes/app_route.dart';
import '../../../../common/widget/no_product.dart';
import '../../../../core/api_config.dart';
import '../../../../core/app_res.dart';
import '../../../../core/app_string.dart';
import '../../../../core/utils.dart';
import '../../../order/bloc/order_bloc.dart';
import '../../../user/data/model/user_model.dart';
part '../widget/_item_cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderBloc(orderRepository: context.read<OrderRepository>()),
      child: CartView(user: user),
    );
  }
}

class CartView extends StatefulWidget {
  const CartView({super.key, required this.user});
  final UserModel user;
  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late final WebSocketChannel _tableChannel;
  late final WebSocketChannel _orderChannel;
  var _isFirstSendSocket = false;
  late UserModel _user;
  @override
  void initState() {
    super.initState();
    _user = widget.user;
    _tableChannel = IOWebSocketChannel.connect(
        Uri.parse(ApiConfig.tablesSocketUrl),
        headers: {
          ConstRes.userID: _user.id.toString(),
        });
    _orderChannel = IOWebSocketChannel.connect(
        Uri.parse(ApiConfig.ordersSocketUrl),
        headers: {
          ConstRes.userID: _user.id.toString(),
        });
  }

  @override
  void dispose() {
    super.dispose();
    disconnect();
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
    var cartState = context.watch<CartCubit>().state;
    var tableState = context.watch<TableCubit>().state;

    if (!_isFirstSendSocket) {
      Ultils.joinRoom(_tableChannel, 'tables-${_user.id}');
      Ultils.joinRoom(_orderChannel, 'orders-${_user.id}');
      _isFirstSendSocket = true;
    }
    return Scaffold(
      // backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: FittedBox(child: Text(AppString.cart)),
        leading: CommonBackButton(onTap: () => context.pop()),
      ),
      bottomNavigationBar: Card(
        elevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Container(
          height: 130,
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppString.total,
                      style: context.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${Ultils.currencyFormat(
                        double.parse(
                          cartState.totalPrice.toString(),
                        ),
                      )} ₫',
                      style: context.bodyMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary),
                    ),
                  ],
                ),
              ),
              _buildPayButton(cartState, tableState),
            ],
          ),
        ),
      ),
      body: cartState.orderDetail.isEmpty
          ? const NoProduct()
          : BlocListener<OrderBloc, OrderState>(
              listener: (context, state) {
                switch (state) {
                  case OrderCreateInProgress():
                    AppDialog.showLoadingDialog(context);
                    break;
                  case OrderCreateSuccess():
                    context.read<CartCubit>().clearCart();
                    context.read<TableCubit>().resetTable();

                    Ultils.sendSocket(_tableChannel, 'tables', _user.id);
                    Ultils.sendSocket(_orderChannel, 'orders',
                        {'user_id': _user.id, 'table_id': 0});
                    context.go(AppRoute.createOrderSuccess);

                    break;
                  case OrderCreateFailure():
                    AppDialog.showErrorDialog(context,
                        returnedLevel: 2,
                        haveCancelButton: true,
                        title: state.error,
                        confirmText: 'Thử lại', onPressedComfirm: () {
                      context.read<OrderBloc>().add(OrderCreated(cartState));
                    });

                    break;
                  default:
                    break;
                }
              },
              child: ListView.builder(
                  itemCount: cartState.orderDetail.length,
                  padding: const EdgeInsets.all(defaultPadding),
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return _itemCart(cartState, cartState.orderDetail[index]);
                  }),
            ),
    );
  }

  Widget _buildPayButton(OrderModel order, TableModel table) {
    return InkWell(
      onTap: order.orderDetail.isEmpty
          ? null
          : () => submitCreateOrder(order, table),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        width: double.infinity,
        decoration: BoxDecoration(
          color: order.orderDetail.isEmpty
              ? context.colorScheme.outline
              : context.colorScheme.primary,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          AppString.order,
          style: context.bodyMedium!.copyWith(color: Colors.white),
        ),
      ),
    );
  }

  void submitCreateOrder(OrderModel order, TableModel table) {
    AppDialog.showErrorDialog(
      context,
      title: 'Lên đơn nhó!',
      description: 'Đơn lên sẽ không thể sửa, kiểm tra kĩ trước khi lên đơn!',
      confirmText: 'Ừ! lên đi',
      cancelText: 'Thôi!',
      haveCancelButton: true,
      onPressedComfirm: () {
        _handleCreateOrder(order, table);
      },
    );
  }

  void _handleCreateOrder(OrderModel order, TableModel table) {
    context.pop();
    order = order.copyWith(tableID: table.id, tableName: table.name);

    context.read<OrderBloc>().add(OrderCreated(order));
  }
}
