part of '../screens/order_screen.dart';

extension _BodyWidget on _OrderScreenState {
  Widget _bodyWidget() {
    return Container(
      constraints: const BoxConstraints(maxWidth: 1707),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.all(5).r,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(defaultBorderRadius).r,
          ),
          child: Builder(builder: (context) {
            var newOrdersState = context.watch<OrderBloc>().state;
            return (switch (newOrdersState) {
              OrderFetchNewOrdersSuccess() =>
                _tableWidget(newOrdersState.orderList),
              OrderFetchNewOrdersFailure() =>
                ErrWidget(error: newOrdersState.message),
              OrderFetchNewOrdersInProgress() => const Loading(),
              _ => const SizedBox.shrink(),
            });
          }),
        ),
      ),
    );
  }

  Widget _tableWidget(List<OrderModel> orders) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 71.h,
          alignment: Alignment.center,
          child: Table(
            // border: TableBorder.all(),

            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(100),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              5: FixedColumnWidth(64),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildRowTitle(),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
              child: Table(
                  // border: TableBorder.all(),
                  columnWidths: const <int, TableColumnWidth>{
                0: FixedColumnWidth(100),
                1: FlexColumnWidth(),
                2: FlexColumnWidth(),
                3: FlexColumnWidth(),
                5: FixedColumnWidth(64),
              },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: orders
                      .asMap()
                      .map((index, value) =>
                          MapEntry(index, _buildRowTable(index, value)))
                      .values
                      .toList())),
        ),
      ],
    );
  }

  TableRow _buildRowTitle() {
    return TableRow(
      children: _listTitleTable
          .map((e) => Text(
                e,
                textAlign: TextAlign.center,
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondTextColor),
              ))
          .toList(),
    );
  }

  TableRow _buildRowTable(int index, OrderModel order) {
    return TableRow(
      decoration: BoxDecoration(
        color:
            index.isEven ? AppColors.black.withOpacity(0.1) : AppColors.white,
      ),
      children: <Widget>[
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            '${index + 1}',
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils().formatDateToString(order.createdAt, isShort: true),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            order.foodOrders.length.toString(),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.currencyFormat(order.totalPrice),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: CommonIconButton(
            onTap: () {},
            icon: Icons.remove_red_eye,
            color: AppColors.islamicGreen,
            tooltip: 'Xem đơn hàng',
          ),
        ),
      ],
    );
  }
}
