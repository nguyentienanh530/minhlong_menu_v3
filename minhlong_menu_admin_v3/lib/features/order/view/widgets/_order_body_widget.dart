part of '../screens/order_screen.dart';

extension _OrderBodyWidget on _OrderScreenState {
  Widget _orderBodyWidget() {
    return Container(
      padding: const EdgeInsets.all(5).r,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadius).r,
      ),
      child: Builder(builder: (context) {
        var newOrdersState = context.watch<OrderBloc>().state;
        return (switch (newOrdersState) {
          OrderFetchNewOrdersSuccess() => _tableWidget(newOrdersState.orders),
          OrderFetchNewOrdersFailure() =>
            ErrWidget(error: newOrdersState.message),
          OrderFetchNewOrdersInProgress() => const Loading(),
          _ => const SizedBox.shrink(),
        });
      }),
    );
  }

  Widget _tableWidget(OrderModel orders) {
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
                  children: orders.orderItems
                      .asMap()
                      .map((index, value) =>
                          MapEntry(index, _buildRowTable(index, value)))
                      .values
                      .toList())),
        ),
        Container(
          width: double.infinity,
          height: 71.h,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10).r,
          child: Row(
            children: [
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'Hiển thị 1 đến 10 trong số 100 đơn',
                    style:
                        kBodyStyle.copyWith(color: AppColors.secondTextColor),
                  ),
                ),
              ),
              const Spacer(),
              SizedBox(
                width: 250,
                child: NumberPaginator(
                  initialPage: 4,
                  controller: _numberPaginatorcontroller,
                  // by default, the paginator shows numbers as center content
                  numberPages: orders.totalPage,
                  onPageChange: (int index) {
                    // _currentPage = index;
                  },
                  config: NumberPaginatorUIConfig(
                      buttonShape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(textFieldBorderRadius),
                      ),
                      buttonPadding: const EdgeInsets.symmetric(
                        horizontal: -10,
                      ),
                      buttonTextStyle: kBodyStyle,
                      buttonSelectedForegroundColor: AppColors.white,
                      buttonUnselectedForegroundColor:
                          AppColors.secondTextColor,
                      buttonUnselectedBackgroundColor:
                          AppColors.black.withOpacity(0.1),
                      buttonSelectedBackgroundColor: AppColors.red,
                      mainAxisAlignment: MainAxisAlignment.center),
                ),
              ),
            ],
          ),
        )
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

  TableRow _buildRowTable(int index, OrderItem orderItem) {
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
            Ultils().formatDateToString(orderItem.createdAt, isShort: true),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            orderItem.foodOrders.length.toString(),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.currencyFormat(orderItem.totalPrice),
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
