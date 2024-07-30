part of '../screens/order_screen.dart';

extension _OrderDetailDialog on _OrderViewState {
  Widget _orderDetailDialog(OrderItem orderItem, List<int> listID) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      contentPadding: const EdgeInsets.only(top: 10.0),
      title: _buildHeaderDialog(),
      backgroundColor: AppColors.background,
      actionsAlignment: MainAxisAlignment.center,
      content: SizedBox(
          height: 890.h,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildTimeOrderDialog(orderItem),
                  10.verticalSpace,
                  _buildBodyDialog(orderItem),
                  // _buildBottomDialog(orderItem)
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
          )),
      actions: [
        Row(
          children: [
            Expanded(
              child: _buttonAction(
                title: 'In đơn',
                icon: const Icon(Icons.print, color: AppColors.white),
                onTap: () {
                  context.push(AppRoute.printScreen, extra: orderItem);
                },
                color: AppColors.red,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: _buttonAction(
                title: 'Thanh toán',
                icon: const Icon(Icons.payment, color: AppColors.white),
                onTap: () {
                  AppDialog.showWarningDialog(context,
                      title: 'Xác nhận thanh toán',
                      description: 'Kiểm tra kĩ trước khi thanh toán!',
                      onPressedComfirm: () {
                    // orderItem = orderItem.copyWith(status: 'processing');
                    // _handleUpdateOrder(
                    //     orderID: orderItem.id, status: 'processing');
                    context.pop();
                    context
                        .read<OrderBloc>()
                        .add(OrderPayed(order: orderItem, ids: listID));
                  });
                },
                color: AppColors.blue,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildHeaderDialog() {
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 8,
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Chi tiết đơn hàng",
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

  Widget _buildBottomDialog(OrderItem orderItem) {
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
            _buildActionButton(orderItem)
          ]),
        ));
  }

  Widget _buildActionButton(OrderItem orderItem) {
    switch (orderItem.status) {
      case 'new':
        return const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [],
        );

      case 'processing':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: _buttonAction(
                title: 'In đơn',
                icon: const Icon(Icons.print),
                onTap: () {
                  AppDialog.showWarningDialog(context,
                      title: 'Huỷ đơn',
                      description: 'Bạn có muốn huỷ đơn ${orderItem.id}?',
                      onPressedComfirm: () {
                    // orderItem = orderItem.copyWith(status: 'cancel');

                    _handleUpdateOrder(orderID: orderItem.id, status: 'cancel');
                  });
                },
                color: AppColors.red,
              ),
            ),
            10.horizontalSpace,
            Expanded(
              child: _buttonAction(
                title: 'Hoàn thành',
                onTap: () {
                  AppDialog.showWarningDialog(context,
                      title: 'Hoàn thành!',
                      description:
                          'Đơn đã xong, chuyển đơn ${orderItem.id} tới hoàn thành?',
                      onPressedComfirm: () {
                    // orderItem = orderItem.copyWith(
                    //     status: 'completed',
                    //     payedAt: DateTime.now().toString());

                    _handleUpdateOrder(
                        orderID: orderItem.id, status: 'completed');
                  });
                },
                color: AppColors.blue,
              ),
            ),
          ],
        );

      case 'completed':
        return const SizedBox();
      // return _buttonAction(
      //   title: 'Xóa đơn',
      //   onTap: () {
      //     // _showOrderCancelDialog(orderItem);
      //   },
      //   color: AppColors.blue,
      // );
      default:
        return const SizedBox();
    }
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

  _buildTimeOrderDialog(OrderItem orderItem) {
    return Column(
      children: [
        _buildItemTimeOrder(
            title: 'Thời gian đặt:',
            value:
                Ultils.formatDateToString(orderItem.createdAt!, isTime: true)),
        _buildItemTimeOrder(
            title: 'Thời gian thanh toán:',
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
