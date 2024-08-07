import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:minhlong_menu_client_v3/common/widgets/common_back_button.dart';
import 'package:minhlong_menu_client_v3/common/widgets/empty_widget.dart';
import 'package:minhlong_menu_client_v3/common/widgets/loading.dart';
import 'package:minhlong_menu_client_v3/core/extensions.dart';
import 'package:minhlong_menu_client_v3/features/table/cubit/table_cubit.dart';
import 'package:minhlong_menu_client_v3/features/table/data/model/table_model.dart';

import '../../../../common/widgets/error_widget.dart';
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
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        leading: CommonBackButton(onTap: () => context.pop()),
        centerTitle: true,
        title: Text(
          AppString.chooseTable,
          style: context.titleStyleLarge!.copyWith(fontWeight: FontWeight.bold),
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
            TableFetchSuccess() => GridView.builder(
                // shrinkWrap: true,
                itemCount: tableState.tables.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 16 / 9),
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
