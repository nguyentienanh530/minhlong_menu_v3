part of '../screens/order_history_screen.dart';

extension _OrderDetailDialog on _OrderViewState {
  Widget _orderDetailDialog(OrderItem orderItem) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      title: _buildHeaderDialog(orderItem),
      backgroundColor: AppColors.background,
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
        height: 890.h,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTimeOrderDialog(orderItem),
                10.verticalSpace,
                _buildBodyDialog(orderItem),
                10.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Tổng tiền: ',
                      style: kBodyStyle.copyWith(fontWeight: FontWeight.w700),
                    ),
                    Text(
                      '${Ultils.currencyFormat(orderItem.totalPrice)} đ',
                      style: kBodyStyle.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        _buttonAction(
            title: 'In đơn',
            icon: const Icon(
              Icons.print,
              color: AppColors.white,
            ),
            onTap: () {
              context.push(AppRoute.printScreen, extra: orderItem);
            },
            color: AppColors.themeColor),
      ],
    );
  }

  Widget _buildHeaderDialog(OrderItem orderItem) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Chi tiết đơn hàng #${orderItem.id}",
              style: kSubHeadingStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            children: [
              10.horizontalSpace,
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.close),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buttonAction(
      {required String title,
      required Function() onTap,
      required Color color,
      Widget? icon}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
            color: color),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon ?? const SizedBox(),
            10.horizontalSpace,
            Text(
              title,
              style: kBodyWhiteStyle.copyWith(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    );
  }

  _buildBodyDialog(OrderItem orderItem) {
    return Column(
      children: [
        Container(
          color: AppColors.white,
          child: Table(
              border: const TableBorder(
                top: BorderSide(color: AppColors.secondTextColor),
                left: BorderSide(color: AppColors.secondTextColor),
                right: BorderSide(color: AppColors.secondTextColor),
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(0.5),
                2: FlexColumnWidth(),
              },
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: [
                TableRow(children: [
                  _buildItemTitle(title: 'Món ăn'),
                  _buildItemTitle(title: 'Số lượng'),
                  _buildItemTitle(title: 'Giá')
                ])
              ]),
        ),
        Table(
            border: TableBorder.all(
              color: AppColors.secondTextColor,
            ),
            columnWidths: const <int, TableColumnWidth>{
              0: FlexColumnWidth(),
              1: FlexColumnWidth(0.5),
              2: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: orderItem.foodOrders
                .asMap()
                .map((index, value) =>
                    MapEntry(index, _buildRowTableDialog(value)))
                .values
                .toList()),
      ],
    );
  }

  Container _buildItemTitle({required String title}) {
    return Container(
      alignment: Alignment.center,
      height: 40,
      child: Text(
        title,
        style: kBodyStyle.copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }

  TableRow _buildRowTableDialog(FoodOrderModel foodOrder) {
    return TableRow(
      children: <Widget>[
        Container(
          height: 40,
          alignment: Alignment.center,
          child: Text(
            foodOrder.name,
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 40.h,
          alignment: Alignment.center,
          child: Text(
            foodOrder.quantity.toString(),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 40.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.currencyFormat(foodOrder.totalAmount),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
      ],
    );
  }

  _buildTimeOrderDialog(OrderItem orderItem) {
    return Column(
      children: [
        _buildItemTimeOrder(
          title: 'bàn: ',
          value: orderItem.tableName,
        ),
        _buildItemTimeOrder(
          title: 'Thời gian đặt: ',
          value: Ultils.formatDateToString(orderItem.createdAt!, isTime: true),
        ),
        _buildItemTimeOrder(
            title: 'Thời gian thanh toán: ',
            value: orderItem.payedAt == null
                ? 'Chưa thanh toán'
                : Ultils.formatDateToString(orderItem.payedAt!, isTime: true)),
      ],
    );
  }

  _buildItemTimeOrder({
    String? title,
    String? value,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title ?? '',
            style: kBodyStyle.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            value!,
            style: kBodyStyle.copyWith(
              color: AppColors.secondTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
