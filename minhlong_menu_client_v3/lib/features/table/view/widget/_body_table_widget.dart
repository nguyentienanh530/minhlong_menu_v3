part of '../screen/table_view.dart';

extension _BodyTableWidget on _TableViewState {
  Widget _tableItem(TableModel table) {
    return Card(
      elevation: 3,
      child: Column(
        children: [
          10.verticalSpace,
          FittedBox(
            child: Text(
              table.name,
              style: kSubHeadingStyle.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Flexible(
            child: Text(
              'Ghế : ${table.seats}',
              style: kCaptionStyle.copyWith(color: AppColors.secondTextColor),
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
                  color: AppColors.themeColor,
                  borderRadius: BorderRadius.circular(defaultBorderRadius)),
              child: Text(
                AppString.check,
                style: kButtonWhiteStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
