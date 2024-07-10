import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:minhlong_menu_admin_v3/core/extensions.dart';

import '../../../../common/dialog/app_dialog.dart';
import '../../../../common/widget/common_icon_button.dart';
import '../../../../core/app_colors.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_style.dart';
part '../widgets/_header_dinner_table.dart';
// part '../widgets/_body_dinner_table.dart';

class DinnerTableScreen extends StatelessWidget {
  const DinnerTableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DinnerTableView();
  }
}

class DinnerTableView extends StatefulWidget {
  const DinnerTableView({super.key});

  @override
  State<DinnerTableView> createState() => _DinnerTableViewState();
}

class _DinnerTableViewState extends State<DinnerTableView> {
  final _limit = ValueNotifier(10);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _headerDinnerTableWidget,
        const Spacer()
        // Expanded(
        //   // child: _bodyDinnerTableWidget,
        // ),
      ],
    );
  }
}
