part of '../screens/order_screen.dart';

extension _OrdersOnTableWidget on _OrderViewState {
  Widget _buildOrdersOnTable(int tableIndexSelectedState) {
    return StreamBuilder(
        stream: _orderChannel.stream,
        builder: (context, snapshot) {
          var tableIndexState = context.watch<TableIndexSelectedCubit>().state;
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Loading();
            default:
              if (snapshot.hasError) {
                return const ErrWidget(error: 'Error');
              } else {
                if (!snapshot.hasData) {
                  return const EmptyWidget();
                } else {
                  ordersList.clear();
                  List<OrderItem> orders = <OrderItem>[];

                  var res = jsonDecode(snapshot.data);

                  String event = res['event'].toString();
                  if (event.contains('orders-ws')) {
                    var data = jsonDecode(res['payload']);

                    orders = List<OrderItem>.from(
                      data.map(
                        (x) => OrderItem.fromJson(x),
                      ),
                    );

                    log('orders $orders');
                    if (tableIndexState != 0) {
                      for (var order in orders) {
                        if (order.tableId == tableIndexState) {
                          ordersList.add(order);
                        }
                      }
                    } else {
                      ordersList = orders;
                    }

                    // return ListenableBuilder(
                    //   listenable: _orderList,
                    //   builder: (context, child) {

                    //   },
                    // );

                    return ordersList.isEmpty
                        ? SizedBox(
                            height: 500,
                            width: double.infinity,
                            child: Center(
                              child: Text(
                                'không có đơn nào!',
                                style: kBodyStyle.copyWith(
                                  color: AppColors.secondTextColor,
                                ),
                              ),
                            ),
                          )
                        : StaggeredGrid.count(
                            crossAxisCount: _gridCount(),
                            children: ordersList
                                .map((e) =>
                                    _buildItem(e, tableIndexSelectedState))
                                .toList(),
                          );
                  } else {
                    return const SizedBox();
                  }
                }
              }
          }
        });
  }

  int _gridCount() {
    if (context.isMobile) {
      return 2;
    } else if (context.isTablet) {
      return 3;
    } else {
      return 5;
    }
  }

  Widget _buildItem(OrderItem order, int tableIndexSelectedState) {
    return FittedBox(
      child: Card(
        elevation: 10,
        shadowColor: AppColors.lavender,
        child: Container(
          width: 270,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              _buildHeader(context, order),
              const SizedBox(height: 10),
              _buildBody(context, order),
              const SizedBox(height: 10),
              _buildFooter(context, order, tableIndexSelectedState),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(
      BuildContext context, OrderItem order, int tableIndexSelectedState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'x${order.foodOrders.length} món',
              style: kCaptionStyle.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.secondTextColor,
              ),
            ),
            Text(
              '${Ultils.currencyFormat(double.parse(order.totalPrice.toString()))} đ',
              style: kBodyStyle.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        const SizedBox(
          width: defaultPadding / 2,
        ),
        order.status == 'new'
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CommonIconButton(
                    onTap: () {
                      AppDialog.showWarningDialog(context,
                          title: 'Hủy đơn',
                          description: 'Bạn có muốn huỷ đơn ${order.id}?',
                          onPressedComfirm: () {
                        _handleUpdateOrder(orderID: order.id, status: 'cancel');
                      });
                    },
                    icon: Icons.clear_rounded,
                    color: Colors.red,
                    tooltip: 'Hủy đơn',
                  ),
                  const SizedBox(
                    width: defaultPadding / 2,
                  ),
                  CommonIconButton(
                    tooltip: 'Xác nhận đơn',
                    onTap: () {
                      AppDialog.showWarningDialog(context,
                          title: 'Xác nhận đơn!',
                          description: 'Chuyển đơn ${order.id} sang đang làm?',
                          onPressedComfirm: () {
                        // order = order.copyWith(status: 'processing');

                        _handleUpdateOrder(
                            orderID: order.id, status: 'processing');
                      });
                    },
                    icon: Icons.check,
                    color: AppColors.islamicGreen,
                  ),
                ],
              )
            : Row(
                children: [
                  CommonIconButton(
                    tooltip: 'Sửa đơn',
                    onTap: () async {
                      await context.push<bool>(AppRoute.createOrUpdateOrder,
                          extra: {
                            'order': order,
                            'type': ScreenType.update
                          }).then(
                        (value) {
                          if (value != null && value) {
                            Ultils.sendSocket(
                                _tableChannel, 'tables', _user.id);
                            Ultils.sendSocket(_orderChannel, 'orders', {
                              'user_id': _user.id,
                              'table_id': tableIndexSelectedState
                            });
                          }
                        },
                      );
                    },
                    icon: Icons.edit,
                    color: AppColors.sun,
                  ),
                  10.horizontalSpace,
                  CommonIconButton(
                    tooltip: 'Xóa đơn',
                    onTap: () async {
                      AppDialog.showWarningDialog(context,
                          title: 'Xác nhận xóa!',
                          description:
                              'Kiểm tra kĩ trước khi xóa đơn #${order.id}!',
                          onPressedComfirm: () {
                        _handleDeleteOrder(orderID: order.id);
                      });
                    },
                    icon: Icons.delete,
                    color: AppColors.red,
                  ),
                ],
              ),
      ],
    );
  }

  // void _handleUpdateOrder(OrderItem orderItem) {
  //   context.read<OrderBloc>().add(OrderUpdated(order: orderItem));
  //   context.pop();
  // }

  Widget _buildHeader(BuildContext context, OrderItem order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Đơn hàng #${order.id}',
          style: kSubHeadingStyle.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          Ultils.formatDateToString(
              order.createdAt ?? DateTime.now().toString()),
          style: kCaptionStyle.copyWith(
            fontSize: 10,
            color: AppColors.secondTextColor,
            fontWeight: FontWeight.w400,
          ),
        ),
        10.verticalSpace,
        Container(
          padding: const EdgeInsets.all(5).r,
          decoration: BoxDecoration(
            color: _handleColor(order.status).withOpacity(0.2),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text(
            _handleStatus(order.status),
            style: kBodyStyle.copyWith(color: _handleColor(order.status)),
          ),
        ),
        10.verticalSpace,
      ],
    );
  }

  Widget _buildBody(BuildContext context, OrderItem order) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: order.foodOrders
          .map(
            (e) => Container(
              margin: const EdgeInsets.only(bottom: defaultPadding / 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                        width: 45,
                        height: 45,
                        child: CachedNetworkImage(
                          imageUrl: '${ApiConfig.host}${e.image1 ?? ''}',
                          fit: BoxFit.cover,
                          errorWidget: errorBuilderForImage,
                          width: 45,
                          height: 45,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e.name,
                              style: kBodyStyle.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Ultils.currencyFormat(e.totalAmount),
                                  style: kBodyStyle.copyWith(
                                    color: AppColors.secondTextColor,
                                  ),
                                ),
                                Text(
                                  'x${e.quantity}',
                                  style: kBodyStyle.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                            e.note.isNotEmpty
                                ? Divider(
                                    height: 1,
                                    color: AppColors.secondTextColor
                                        .withOpacity(0.5),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  _buildNote(e.note),
                  const SizedBox(height: 10),
                  Divider(
                    height: 1,
                    color: AppColors.secondTextColor.withOpacity(0.5),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildNote(String note) {
    return note.isNotEmpty
        ? Column(
            children: [
              Text(
                '*Ghi chú',
                style: kBodyStyle.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                note,
                style: kCaptionStyle.copyWith(
                  fontSize: 10,
                  color: AppColors.secondTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          )
        : const SizedBox();
  }
}
