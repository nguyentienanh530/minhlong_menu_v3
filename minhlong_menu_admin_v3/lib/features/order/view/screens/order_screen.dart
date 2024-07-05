import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/common/network/dio_client.dart';
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
import 'package:minhlong_menu_admin_v3/features/order/data/provider/order_api.dart';
import 'package:number_pagination/number_pagination.dart';

import '../../bloc/order_bloc.dart';
import '../../data/model/order_item.dart';
import '../../data/model/order_model.dart';
import '../../data/respositories/order_repository.dart';
part '../widgets/_order_header_widget.dart';
part '../widgets/_order_body_widget.dart';
part '../widgets/_order_detail_dialog.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          OrderRepository(orderApi: OrderApi(DioClient().dio!)),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => OrderBloc(context.read<OrderRepository>())
              ..add(OrderFetchNewOrdersStarted(
                  status: 'new', page: 1, limit: 10)),
          ),
          BlocProvider(
            create: (context) => PaginationCubit(),
          ),
        ],
        child: const OrderView(),
      ),
    );
  }
}

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> with TickerProviderStateMixin {
  final List<DropdownMenuItem<String>> _itemsDropdown = [
    const DropdownMenuItem(value: '10', child: Text('10')),
    const DropdownMenuItem(value: '20', child: Text('20')),
    const DropdownMenuItem(value: '30', child: Text('30')),
    const DropdownMenuItem(value: '40', child: Text('40')),
    const DropdownMenuItem(value: '50', child: Text('50')),
    const DropdownMenuItem(value: '60', child: Text('60')),
    const DropdownMenuItem(value: '70', child: Text('70')),
    const DropdownMenuItem(value: '80', child: Text('80')),
    const DropdownMenuItem(value: '90', child: Text('90')),
    const DropdownMenuItem(value: '100', child: Text('100')),
  ];
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
  final _listStatus = ['new', 'processing', 'completed', 'cancel', 'deleted'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: Column(
          children: [
            _orderHeaderWidget,
            30.verticalSpace,
            Expanded(child: _orderBodyWidget())
          ],
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
      case 'deleted':
        return 'Đã xóa';
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
      case 'deleted':
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
}
