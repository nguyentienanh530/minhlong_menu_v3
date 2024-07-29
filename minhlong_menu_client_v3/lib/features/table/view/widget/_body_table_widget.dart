part of '../screen/table_view.dart';

extension _BodyTableWidget on _TableViewState {
  Widget _tableItem(TableModel table) {
    return Card(
      elevation: 3,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.only(left: defaultPadding),
                child: Image.asset(
                    table.isUse ? AppAsset.tableEnable : AppAsset.tableDisable),
              )),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FittedBox(
                  child: Text(
                    table.name,
                    style: context.bodyMedium!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Flexible(
                  child: Text(
                    'Ghế : ${table.seats}',
                    style: context.bodyMedium!.copyWith(
                        color: context.bodyMedium!.color!.withOpacity(0.5)),
                  ),
                ),
                10.verticalSpace,
                GestureDetector(
                  onTap: () {
                    context.read<TableCubit>().changeTable(table);
                    context.pop(true);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 30,
                    width: 100,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: context.colorScheme.secondary,
                        borderRadius:
                            BorderRadius.circular(defaultBorderRadius)),
                    child: Text(
                      AppString.check,
                      style: context.bodyMedium!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
