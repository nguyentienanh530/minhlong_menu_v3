part of '../screens/order_screen.dart';

extension _OrderBodyWidget on _OrderViewState {
  Widget _orderBodyWidget() {
    return Container(
      padding: const EdgeInsets.all(5).r,
      decoration: BoxDecoration(
        color: AppColors.white,
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
              5: FlexColumnWidth(),
              6: FixedColumnWidth(100),
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
                    style:
                        kBodyStyle.copyWith(color: AppColors.secondTextColor),
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
                                style: kCaptionStyle.copyWith(
                                  color: AppColors.secondTextColor,
                                ),
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
                        colorPrimary: AppColors.themeColor,
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
    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(50),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
          5: FlexColumnWidth(),
          6: FixedColumnWidth(100),
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
          height: 70,
          alignment: Alignment.center,
          child: Text(
            '${orderItem.id}',
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.formatDateToString(orderItem.createdAt!, isShort: true),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            orderItem.tableName,
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
          child: Text(
            _handleStatus(orderItem.status),
            style: kBodyStyle.copyWith(color: _handleColor(orderItem.status)),
          ),
        ),
        _actionWidget(orderItem),
      ],
    );
  }

  Widget _actionWidget(OrderItem orderItem) {
    switch (orderItem.status) {
      case 'new':
        return Row(
          children: [
            CommonIconButton(
              onTap: () {
                context.push(AppRoute.printScreen, extra: orderItem);
              },
              icon: Icons.print,
              color: AppColors.blue,
              tooltip: 'In',
            ),
            10.horizontalSpace,
            Container(
              height: 70.h,
              alignment: Alignment.center,
              child: CommonIconButton(
                onTap: () {
                  _showDetailDialog(orderItem);
                },
                icon: Icons.mode_edit_outline_outlined,
                color: AppColors.sun,
                tooltip: 'Xem đơn hàng',
              ),
            ),
          ],
        );
      case 'processing':
        return Container(
          height: 70.h,
          alignment: Alignment.center,
          child: CommonIconButton(
            onTap: () {
              _showDetailDialog(orderItem);
            },
            icon: Icons.mode_edit_outline_outlined,
            color: AppColors.sun,
            tooltip: 'Xem đơn hàng',
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
