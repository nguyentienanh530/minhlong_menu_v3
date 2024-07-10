import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';

import '../../../../core/app_asset.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_string.dart';

part '../widget/_table_widget.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  List<TableModel> tableList = List.generate(
      10,
      (index) => TableModel(
          id: index, name: 'Table $index', seats: 4, isUse: index % 2 == 0));
  TableModel tableModel = TableModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: BackButton(onPressed: () => context.pop()),
            title: _titleTable(),
            pinned: context.isPortrait ? true : false,
          ),
          SliverAnimatedGrid(
            initialItemCount: tableList.length,
            itemBuilder: (context, index, animation) => _tableList(index),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 3 / 1,
            ),
          ),
        ],
      ),
    );
  }
}
