part of '../screens/order_history_screen.dart';

extension _OrderBodyWidget on _OrderViewState {
  Widget _orderBodyWidget() {
    return Container(
      padding: const EdgeInsets.all(5).r,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius).r,
      ),
      child: _tableWidget(),
    );
  }

  Widget _tableWidget() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 71,
          alignment: Alignment.center,
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(50),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FixedColumnWidth(200),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildRowTitle(),
            ],
          ),
        ),
        Expanded(
          child: Builder(builder: (context) {
            var newOrdersState = context.watch<OrderBloc>().state;
            switch (newOrdersState) {
              case OrderFetchNewOrdersSuccess():
                context
                    .read<PaginationCubit>()
                    .setPagination(newOrdersState.orders.paginationModel!);
                return SingleChildScrollView(
                    child: _buildWidgetSuccess(newOrdersState.orders));

              case OrderFetchNewOrdersFailure():
                return ErrWidget(error: newOrdersState.message);

              case OrderFetchNewOrdersInProgress():
                return const Loading();

              case OrderFetchNewOrdersEmpty():
                return Center(
                  child: Text(
                    'Không có dữ liệu',
                    style: context.bodyMedium!.copyWith(
                        color:
                            context.titleStyleMedium!.color!.withOpacity(0.5)),
                  ),
                );

              default:
                return const SizedBox();
            }
          }),
        ),
        _buildBottomWidget()

        // _buildBottomWidget(_orderModel.value)
      ],
    );
  }

  Widget _buildBottomWidget() {
    return Builder(
      builder: (context) {
        var pagination = context.watch<PaginationCubit>().state;
        return Container(
          width: double.infinity,
          height: 71,
          padding: const EdgeInsets.all(10).r,
          child: Row(
            children: [
              context.isMobile
                  ? const SizedBox()
                  : Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: ValueListenableBuilder<OrderModel>(
                          valueListenable: _orderModel,
                          builder: (context, order, child) {
                            return ValueListenableBuilder(
                              valueListenable: _limit,
                              builder: (context, limit, child) => Text(
                                'Hiển thị 1 đến $limit trong số ${pagination.totalItem} đơn',
                                style: context.bodyMedium,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
              context.isDesktop ? const Spacer() : const SizedBox(),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _curentPage,
                  builder: (context, value, child) {
                    return Container(
                      alignment: Alignment.centerRight,
                      child: NumberPagination(
                        onPageChanged: (int pageNumber) {
                          _curentPage.value = pageNumber;

                          _fetchData(
                              status: _listStatus[_tabController.index],
                              page: pageNumber,
                              limit: _limit.value);
                        },
                        fontSize: 16,
                        buttonElevation: 10,
                        buttonRadius: textFieldBorderRadius,
                        pageTotal: pagination.totalPage,
                        pageInit: _curentPage.value,
                        colorPrimary: context.colorScheme.primary,
                        colorSub: context.colorScheme.surface,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWidgetSuccess(OrderModel orders) {
    List<OrderItem> mutableOrderItems = List.from(orders.orderItems);
    if (orders.orderItems.first.status == 'cancel') {
      mutableOrderItems.sort((a, b) => b.updatedAt!.compareTo(a.updatedAt!));
      orders = orders.copyWith(orderItems: mutableOrderItems);
    } else {
      mutableOrderItems.sort((a, b) => b.payedAt!.compareTo(a.payedAt!));
      orders = orders.copyWith(orderItems: mutableOrderItems);
    }

    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(50),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
          5: FixedColumnWidth(200),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: orders.orderItems
            .asMap()
            .map(
                (index, value) => MapEntry(index, _buildRowTable(index, value)))
            .values
            .toList());
  }

  TableRow _buildRowTitle() {
    return TableRow(
      children: _listTitleTable
          .map(
            (e) => Text(
              e,
              textAlign: TextAlign.center,
              style: context.bodyMedium!.copyWith(fontWeight: FontWeight.w900),
            ),
          )
          .toList(),
    );
  }

  TableRow _buildRowTable(int index, OrderItem orderItem) {
    return TableRow(
      decoration: BoxDecoration(
        color: index.isEven
            ? Colors.transparent
            : context.colorScheme.inversePrimary.withOpacity(0.2),
      ),
      children: <Widget>[
        Container(
          height: 70,
          alignment: Alignment.center,
          child: Text(
            '${orderItem.id}',
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.formatDateToString(
                orderItem.status == 'cancel'
                    ? orderItem.updatedAt!
                    : orderItem.payedAt!,
                isShort: true),
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            orderItem.foodOrders.length.toString(),
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.currencyFormat(orderItem.totalPrice),
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Container(
            padding: const EdgeInsets.all(10).r,
            decoration: BoxDecoration(
              color: _handleColor(orderItem.status).withOpacity(0.1),
              borderRadius: BorderRadius.circular(defaultBorderRadius / 2),
            ),
            child: Text(
              _handleStatus(orderItem.status),
              style: context.bodyMedium!
                  .copyWith(color: _handleColor(orderItem.status)),
            ),
          ),
        ),
        _actionWidget(orderItem),
      ],
    );
  }

  Widget _actionWidget(OrderItem orderItem) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: CommonIconButton(
            onTap: () {
              _showDetailDialog(orderItem);
            },
            icon: Icons.remove_red_eye,
            color: Colors.green,
            tooltip: 'Xem đơn hàng',
          ),
        ),
        10.horizontalSpace,
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: CommonIconButton(
            onTap: () async {
              // _showDetailDialog(orderItem);
              await context.push<bool>(AppRoute.createOrUpdateOrder,
                  extra: {'order': orderItem, 'type': ScreenType.update}).then(
                (value) {
                  if (value != null && value) {
                    _fetchData(
                        status: _listStatus[_tabController.index],
                        page: _curentPage.value,
                        limit: _limit.value);
                  }
                },
              );
            },
            icon: Icons.edit,
            color: Colors.orange,
            tooltip: 'Sửa đơn hàng',
          ),
        ),
        10.horizontalSpace,
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: CommonIconButton(
            onTap: () {
              AppDialog.showWarningDialog(context,
                  title: 'Xóa đơn',
                  description: 'Bạn có muốn xóa đơn ${orderItem.id}?',
                  onPressedComfirm: () {
                _handleDeleteOrder(orderID: orderItem.id);
              });
            },
            icon: Icons.delete_outline,
            color: Colors.red,
            tooltip: 'Xóa đơn',
          ),
        ),
        10.horizontalSpace,
      ],
    );
  }
}
