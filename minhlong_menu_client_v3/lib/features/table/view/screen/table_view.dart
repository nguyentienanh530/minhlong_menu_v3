import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widget/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widget/empty_widget.dart';
import 'package:minhlong_menu_client_v3/common/widget/loading.dart';
import 'package:minhlong_menu_client_v3/core/app_colors.dart';
import 'package:minhlong_menu_client_v3/core/app_style.dart';
import 'package:minhlong_menu_client_v3/features/table/cubit/table_cubit.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';

import '../../../../common/widget/error_widget.dart';
import '../../../../core/app_asset.dart';
import '../../../../core/app_const.dart';
import '../../../../core/app_string.dart';
import '../../bloc/table_bloc.dart';

part '../widget/_body_table_widget.dart';

class TableView extends StatefulWidget {
  const TableView({super.key});

  @override
  State<TableView> createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CommonBackButton(onTap: () => context.pop()),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: FittedBox(
                  child: Text(
                    AppString.chooseTable,
                    style: kHeadingStyle.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20)
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Builder(builder: (context) {
          var tableState = context.watch<TableBloc>().state;
          return (switch (tableState) {
            TableFetchInProgress() => const Loading(),
            TableFetchEmpty() => const EmptyWidget(),
            TableFetchFailure() => ErrWidget(error: tableState.message),
            TableFetchSuccess() => ListView.builder(
                // shrinkWrap: true,
                itemCount: tableState.tables.length,
                itemBuilder: (context, index) {
                  return _tableItem(tableState.tables[index]);
                },
              ),
            _ => const SizedBox()
          });
        }),
      ),
    );
  }
}
