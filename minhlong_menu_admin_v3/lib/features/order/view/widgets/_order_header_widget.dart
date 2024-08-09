part of '../screens/order_screen.dart';

extension _OrderHeaderWidget on _OrderViewState {
  Widget _orderHeaderWidget(
          int tableIndexSelectedState, List<OrderItem> orders) =>
      SizedBox(
        // height: 80.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // _buildTabbarWidget(),
            tableIndexSelectedState != 0
                ? _buildButtonPayment(orders)
                : const SizedBox(),
            10.horizontalSpace,
            // _buildDropdown(),
            _buildAddOrder(tableIndexSelectedState)
          ],
        ),
      );

  Widget _buildAddOrder(int tableIndexSelectedState) {
    return ElevatedButton(
        onPressed: () async => await context.push<bool>(
                AppRoute.createOrUpdateOrder,
                extra: {'type': ScreenType.create}).then((value) {
              if (value != null && value) {
                _socket.sendSocket(AppKeys.tables, AppKeys.tables, _user.id);
                _socket.sendSocket(AppKeys.orders, AppKeys.orders, {
                  'user_id': _user.id,
                  'table_id': tableIndexSelectedState,
                });
              }
            }),
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(context.colorScheme.primary),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius)))),
        child: Text(
          'Thêm',
          style: context.bodyMedium!
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ));
  }

  Widget _buildButtonPayment(List<OrderItem> orderItem) {
    return ElevatedButton(
        onPressed: () async {
          var isNew = orderItem.any((element) => element.status == 'new');
          if (!isNew) {
            _showDetailDialog(orderItem);
          } else {
            OverlaySnackbar.show(context, 'Có đơn chưa xác chuyển trạng thái',
                type: OverlaySnackbarType.error);
          }
        },
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(context.colorScheme.primary),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius)))),
        child: Text(
          'Thanh toán',
          style: context.bodyMedium!.copyWith(color: Colors.white),
        ));
  }
}
