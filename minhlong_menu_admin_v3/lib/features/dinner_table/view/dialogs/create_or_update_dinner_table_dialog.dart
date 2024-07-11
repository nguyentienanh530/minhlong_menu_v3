import 'package:flutter/material.dart';
import 'package:minhlong_menu_admin_v3/features/dinner_table/data/model/table_item.dart';

enum DinnerTableDialogAction { create, update }

class CreateOrUpdateDinnerTableDialog extends StatefulWidget {
  const CreateOrUpdateDinnerTableDialog(
      {super.key, required this.action, this.tableItem});
  final DinnerTableDialogAction action;
  final TableItem? tableItem;

  @override
  State<CreateOrUpdateDinnerTableDialog> createState() =>
      _CreateOrUpdateDinnerTableDialogState();
}

class _CreateOrUpdateDinnerTableDialogState
    extends State<CreateOrUpdateDinnerTableDialog> {
  @override
  Widget build(BuildContext context) {
    return const SizedBox(width: 500, height: 500, child: Column());
  }
}
