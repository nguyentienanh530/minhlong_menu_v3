part of '../screens/order_screen.dart';

extension _TableWidget on _OrderViewState {
  Widget _buildTablesWidget({required int index}) {
    // return StreamBuilder(
    //   stream: _webSocketManager.getStream('tables'),
    //   builder: (context, snapshot) {
    //     print('snapshot: ${snapshot.data}');
    //     switch (snapshot.connectionState) {
    //       case ConnectionState.waiting:
    //         return const Loading();

    //       default:
    //         if (snapshot.hasError) {
    //           return const ErrWidget(error: '');
    //         } else {
    //           if (!snapshot.hasData) {
    //             return const EmptyWidget();
    //           } else {
    //             var res = jsonDecode(snapshot.data);
    //             String event = res['event'].toString();
    //             if (event.contains('tables-ws')) {
    //               var data = jsonDecode(res['payload']);
    //               dinnerTable = List<TableItem>.from(
    //                   data.map((x) => TableItem.fromJson(x)));

    //               return _buildTableWidget(
    //                 index: index,
    //                 dinnerTable: dinnerTable,
    //               );
    //             }

    //             return const SizedBox();
    //           }
    //         }
    //     }
    //   },
    // );

    return Builder(builder: (context) {
      dinnerTable = context.read<TablesCubit>().state;
      return _buildTableWidget(index: index, dinnerTable: dinnerTable);
    });
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
              badgeStyle: badges.BadgeStyle(
                badgeColor: context.colorScheme.primary,
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
                  style: context.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              child: Card(
                surfaceTintColor: context.colorScheme.surfaceTint,
                elevation: 1,
                shadowColor: context.colorScheme.onSurface.withOpacity(0.5),
                shape: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: index == e.id
                        ? context.colorScheme.primary
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(
                    textFieldBorderRadius,
                  ),
                ),
                child: InkWell(
                  onTap: () {
                    context.read<TableIndexSelectedCubit>().changeIndex(e.id);
                    _socket.sendSocket(AppKeys.orders, AppKeys.orders,
                        {'user_id': _user.id, 'table_id': e.id});
                    // Ultils.sendSocket(_orderChannel, 'orders',
                    //     {'user_id': _user.id, 'table_id': e.id});
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(defaultPadding / 2),
                    child: Text(
                      e.name,
                      style: context.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w700,
                        color: index == e.id
                            ? context.colorScheme.primary
                            : context.titleStyleMedium!.color!.withOpacity(0.5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
