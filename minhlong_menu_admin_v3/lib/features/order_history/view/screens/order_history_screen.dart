import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/Routes/app_route.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_admin_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_admin_v3/common/widget/common_icon_button.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/pagination_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';

import '../../../../common/widget/number_pagination.dart';
import '../../../../core/app_enum.dart';
import '../../../order/bloc/order_bloc.dart';
import '../../../order/data/model/order_item.dart';
import '../../../order/data/model/order_model.dart';
import '../../../order/data/repositories/order_repository.dart';

part '../dialogs/_order_history_detail_dialog.dart';
part '../widgets/_order_history_body_widget.dart';
part '../widgets/_order_history_header_widget.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderBloc(context.read<OrderRepository>())
            ..add(
              OrderFetchNewOrdersStarted(
                status: 'completed',
                page: 1,
                limit: 10,
              ),
            ),
        ),
        BlocProvider(
          create: (context) => PaginationCubit(),
        ),
      ],
      child: const OrderView(),
    );
  }
}

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  final _orderModel = ValueNotifier(OrderModel());

  final _listTitleTable = [
    'ID',
    'Ngày',
    'Tổng món',
    'Tổng tiền',
    'Trạng thái',
    'Hành động'
  ];
  final _curentPage = ValueNotifier(1);
  final _limit = ValueNotifier(10);
  late final TabController _tabController;
  final _listStatus = ['completed', 'cancel'];
  final _datePicker = ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _orderModel.dispose();
    _curentPage.dispose();
    _limit.dispose();
    _datePicker.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderUpdateStatusInProgress ||
                state is OrderDeleteInProgress) {
              AppDialog.showLoadingDialog(context);
            }

            if (state is OrderUpdateStatusSuccess) {
              pop(context, 2);
              _fetchData(
                  status: _listStatus[_tabController.index],
                  page: _curentPage.value,
                  limit: _limit.value);
              OverlaySnackbar.show(context, 'Cập nhật thành công');
            }
            if (state is OrderDeleteSuccess) {
              pop(context, 2);
              _fetchData(
                  status: _listStatus[_tabController.index],
                  page: _curentPage.value,
                  limit: _limit.value);

              OverlaySnackbar.show(context, 'Xóa thành công');
            }

            if (state is OrderUpdateStatusFailure) {
              pop(context, 2);
              OverlaySnackbar.show(context, 'Có lỗi xảy ra',
                  type: OverlaySnackbarType.error);
              _fetchData(
                  status: _listStatus[_tabController.index],
                  page: _curentPage.value,
                  limit: _limit.value);
            }

            if (state is OrderDeleteFailure) {
              pop(context, 2);
              OverlaySnackbar.show(context, 'Có lỗi xảy ra',
                  type: OverlaySnackbarType.error);
              _fetchData(
                  status: _listStatus[_tabController.index],
                  page: _curentPage.value,
                  limit: _limit.value);
            }
          },
          child: Column(
            children: [
              _orderHeaderWidget,
              30.verticalSpace,
              Expanded(child: _orderBodyWidget())
            ],
          ),
        ),
      ),
    );
  }

  void _fetchData(
      {required String status,
      required int page,
      required int limit,
      String? date}) {
    context.read<OrderBloc>().add(OrderFetchNewOrdersStarted(
        status: status, page: page, limit: limit, date: date));
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
        return Colors.orange;
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

  void _showDetailDialog(OrderItem orderItem) {
    showDialog(
      context: context,
      builder: (context) => _orderDetailDialog(orderItem),
    );
  }

  _handleDeleteOrder({required int orderID}) {
    context.read<OrderBloc>().add(OrderDeleted(id: orderID));
  }

  @override
  bool get wantKeepAlive => true;
}
