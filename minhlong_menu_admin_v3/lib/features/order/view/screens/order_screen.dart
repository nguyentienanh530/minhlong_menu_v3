import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/app_colors.dart';
import 'package:minhlong_menu_admin_v3/core/app_const.dart';
import 'package:minhlong_menu_admin_v3/core/app_style.dart';
part '../widgets/_header_widget.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30).r,
        child: Column(
          children: [_headerWidget],
        ),
      ),
    );
  }
}
