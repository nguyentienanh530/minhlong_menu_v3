part of '../screen/table_view.dart';

extension on _TableViewState {
  Widget _tableItem(TableModel table) {
    return Card(
      surfaceTintColor: context.colorScheme.surfaceTint,
      elevation: 1,
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          width: 3,
          color: _currentTable.id == table.id
              ? context.colorScheme.primary
              : Colors.transparent,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                  table.isUse ? AppAsset.tableEnable : AppAsset.tableDisable),
            ),
            20.verticalSpace,
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FittedBox(
                    child: Text(
                      table.name,
                      style: context.bodyMedium!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Ghế : ${table.seats}',
                    style: context.bodyMedium!.copyWith(
                        color: context.bodyMedium!.color!.withOpacity(0.5)),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TableCubit>().changeTable(table);
                      context.pop(true);
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(context.colorScheme.primary),
                    ),
                    child: Text(
                      _currentTable.id == table.id
                          ? AppString.checked
                          : AppString.check,
                      style: context.bodyMedium!.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
