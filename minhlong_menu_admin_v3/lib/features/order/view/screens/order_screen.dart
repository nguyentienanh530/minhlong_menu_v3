import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_admin_v3/common/dialog/app_dialog.dart';
import 'package:minhlong_menu_admin_v3/common/snackbar/overlay_snackbar.dart';
import 'package:minhlong_menu_admin_v3/common/widget/common_icon_button.dart';
import 'package:minhlong_menu_admin_v3/common/widget/error_widget.dart';
import 'package:minhlong_menu_admin_v3/common/widget/loading.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_style.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';
import 'package:minhlong_menu_admin_v3/core/utils.dart';
import 'package:minhlong_menu_admin_v3/features/order/cubit/pagination_cubit.dart';
import 'package:minhlong_menu_admin_v3/features/order/data/model/food_order_model.dart';
import 'package:number_pagination/number_pagination.dart';
import '../../bloc/order_bloc.dart';
import '../../data/model/order_item.dart';
import '../../data/model/order_model.dart';
import '../../data/repositories/order_repository.dart';
part '../widgets/_order_header_widget.dart';
part '../widgets/_order_body_widget.dart';
part '../dialogs/_order_detail_dialog.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => OrderBloc(context.read<OrderRepository>())
            ..add(
              OrderFetchNewOrdersStarted(
                status: 'new',
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
  final _listStatus = ['new', 'processing', 'completed', 'cancel'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _orderModel.dispose();
    _curentPage.dispose();
    _limit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderUpdateInProgress ||
                state is OrderDeleteInProgress) {
              AppDialog.showLoadingDialog(context);
            }

            if (state is OrderUpdateSuccess) {
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

            if (state is OrderUpdateFailure) {
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
        return AppColors.pumpkin;
      case 'processing':
        return AppColors.fountainBlue;
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

  void _handleUpdateOrder(OrderItem orderItem) {
    context.read<OrderBloc>().add(OrderUpdated(order: orderItem));
    context.pop();
  }

  _handleDeleteOrder({required int orderID}) {
    context.read<OrderBloc>().add(OrderDeleted(id: orderID));
  }

  @override
  bool get wantKeepAlive => true;
}
