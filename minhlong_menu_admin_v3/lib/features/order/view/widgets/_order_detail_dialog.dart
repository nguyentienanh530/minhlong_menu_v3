part of '../screens/order_screen.dart';

extension _OrderDetailDialog on _OrderViewState {
  Widget _orderDetailDialog(OrderItem orderItem) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      title: _buildHeaderDialog(orderItem.id),
      backgroundColor: AppColors.background,
      content: SizedBox(
          height: 890.h,
          width: 600.w,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              10.verticalSpace,
              Expanded(child: _buildBodyDialog(orderItem)),
              _buildBottomDialog(orderItem)
            ],
          )),
    );
  }

  Widget _buildHeaderDialog(int id) {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Chi tiết đơn hàng #$id",
              style: kSubHeadingStyle.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close),
            ),
          ),
        )
      ],
    );
  }

  _buildBottomDialog(OrderItem orderItem) {
    return Card(
        margin: const EdgeInsets.all(defaultPadding),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(textFieldBorderRadius).r),
        color: AppColors.white,
        elevation: 10,
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: Column(children: [
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
            20.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(textFieldBorderRadius).r,
                        color: AppColors.red),
                    child: Text(
                      'Huỷ đơn',
                      style:
                          kBodyWhiteStyle.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
                10.horizontalSpace,
                Expanded(
                  child: Container(
                    height: 35,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(textFieldBorderRadius).r,
                        color: AppColors.blue),
                    child: Text(
                      'Xác nhận',
                      style:
                          kBodyWhiteStyle.copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
              ],
            )
          ]),
        ));
  }

  _buildBodyDialog(OrderItem orderItem) {
    return Column(
      children: [
        Container(
          color: AppColors.white,
          child: Table(
              border: TableBorder.all(
                color: AppColors.secondTextColor,
              ),
              columnWidths: const <int, TableColumnWidth>{
                0: FlexColumnWidth(),
                1: FlexColumnWidth(),
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
              1: FlexColumnWidth(),
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
}
