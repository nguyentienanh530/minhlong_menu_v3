import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/app_style.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';

part '../widgets/_food_header_widget.dart';
// part '../widgets/_food_body_widget.dart';

class FoodScreen extends StatelessWidget {
  const FoodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FoodView();
  }
}

class FoodView extends StatefulWidget {
  const FoodView({super.key});

  @override
  State<FoodView> createState() => _FoodViewState();
}

class _FoodViewState extends State<FoodView> {
  // final _curentPage = ValueNotifier(1);
  final _limit = ValueNotifier(10);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [_foodHeaderWidget],
    );
  }
}
