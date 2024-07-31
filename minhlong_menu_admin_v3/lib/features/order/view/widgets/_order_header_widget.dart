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
                Ultils.sendSocket(_tableChannel, 'tables', _user.id);
                Ultils.sendSocket(_orderChannel, 'orders',
                    {'user_id': _user.id, 'table_id': tableIndexSelectedState});
              }
            }),
        style: ButtonStyle(
            backgroundColor:
                WidgetStatePropertyAll(context.colorScheme.primary),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius)))),
        child: const Text(
          'Thêm',
          style: kButtonWhiteStyle,
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
        child: const Text(
          'Thanh toán',
          style: kButtonWhiteStyle,
        ));
  }
}
