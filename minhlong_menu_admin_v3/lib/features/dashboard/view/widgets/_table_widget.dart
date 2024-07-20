part of '../screens/dashboard_screen.dart';

extension _TableWidget on _DashboardViewState {
  Widget _buildTablesWidget({required int index}) {
    return StreamBuilder(
      stream: _tableChannel.stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Loading();

          default:
            if (snapshot.hasError) {
              return const ErrWidget(error: '');
            } else {
              if (!snapshot.hasData) {
                return const EmptyWidget();
              } else {
                List<TableItem> dinnerTable = <TableItem>[];
                var res = jsonDecode(snapshot.data);
                String event = res['event'].toString();
                if (event.contains('tables-ws')) {
                  var data = jsonDecode(res['payload']);
                  dinnerTable = List<TableItem>.from(
                      data.map((x) => TableItem.fromJson(x)));
                  return _buildTableWidget(
                    index: index,
                    dinnerTable: dinnerTable,
                  );
                }

                return const SizedBox();
              }
            }
        }
      },
    );
  }

  Widget _buildTableWidget(
      {required int index, required List<TableItem> dinnerTable}) {
    return Wrap(
        clipBehavior: Clip.hardEdge,
        alignment: WrapAlignment.start,
        runAlignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.start,
        children: dinnerTable
            .map(
              (e) => badges.Badge(
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppColors.themeColor,
                ),
                position: badges.BadgePosition.topEnd(
                  top: -10,
                  end: -5,
                ),
                showBadge: e.orderCount == 0 ? false : true,
                badgeContent: SizedBox(
                  width: 15,
                  height: 15,
                  child: Text(
                    e.orderCount.toString(),
                    textAlign: TextAlign.center,
                    style: kBodyWhiteStyle.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                child: InkWell(
                  hoverColor: AppColors.transparent,
                  onTap: () {
                    context.read<TableIndexSelectedCubit>().changeIndex(e.id);
                    Ultils.sendSocket(_orderChannel, 'orders',
                        {'user_id': _user.id, 'table_id': e.id});
                  },
                  child: Card(
                    elevation: 4,
                    color: AppColors.white,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: index == e.id
                            ? AppColors.themeColor
                            : AppColors.white,
                      ),
                      borderRadius: BorderRadius.circular(
                        textFieldBorderRadius,
                      ),
                    ),
                    shadowColor: AppColors.lavender,
                    child: Padding(
                      padding: const EdgeInsets.all(3.5),
                      child: Text(
                        e.name,
                        style: kBodyStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: index == e.id
                              ? AppColors.themeColor
                              : AppColors.secondTextColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            )
            .toList());
  }
}
