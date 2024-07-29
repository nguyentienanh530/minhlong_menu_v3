part of '../screens/order_screen.dart';

extension _OrderHeaderWidget on _OrderViewState {
  Widget _orderHeaderWidget(int tableIndexSelectedState) => SizedBox(
        // height: 80.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // _buildTabbarWidget(),
            tableIndexSelectedState != 0 && _ordersLength > 0
                ? _buildButtonPayment(tableIndexSelectedState)
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
            backgroundColor: const WidgetStatePropertyAll(AppColors.themeColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius)))),
        child: const Text(
          'Thêm',
          style: kButtonWhiteStyle,
        ));
  }

  Widget _buildButtonPayment(int tableIndexSelectedState) {
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
            backgroundColor: const WidgetStatePropertyAll(AppColors.themeColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius)))),
        child: const Text(
          'Thanh toán',
          style: kButtonWhiteStyle,
        ));
  }
}
