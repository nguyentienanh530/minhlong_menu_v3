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
import 'package:minhlong_menu_admin_v3/features/order/data/provider/order_api.dart';

import '../../bloc/order_bloc.dart';
import '../../data/model/order_model.dart';
import '../../data/respositories/order_repository.dart';
part '../widgets/_header_widget.dart';
part '../widgets/_body_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
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

  final _listTitleTable = ['STT', 'Ngày', 'Tổng món', 'Tổng tiền', 'Hành động'];
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) =>
          OrderRepository(orderApi: OrderApi(DioClient().dio!)),
      child: BlocProvider(
        create: (context) => OrderBloc(context.read<OrderRepository>())
          ..add(OrderFetchNewOrdersStarted()),
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(30).r,
            child: Column(
              children: [
                _headerWidget,
                30.verticalSpace,
                Expanded(child: _bodyWidget())
              ],
            ),
          ),
        ),
      ),
    );
  }
}
