import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minhlong_menu_client_v3/common/network/dio_client.dart';
import 'package:minhlong_menu_client_v3/features/table/data/provider/table_api.dart';

import '../../bloc/table_bloc.dart';
import '../../data/repositories/table_repository.dart';
import 'table_view.dart';

class TableScreen extends StatelessWidget {
  const TableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => TableRepository(tableApi: TableApi(dio: dio)),
      child: BlocProvider(
        create: (context) =>
            TableBloc(tableRepository: context.read<TableRepository>())
              ..add(
                TableFetched(),
              ),
        child: const TableView(),
      ),
    );
  }
}
