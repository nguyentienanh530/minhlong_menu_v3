part of '../screens/dashboard_screen.dart';

extension _OrdersOnTableWidget on _DashboardViewState {
  Widget _buildOrdersOnTable() {
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
                  List<OrderItem> orders = <OrderItem>[];
                  List<OrderItem> orderList = <OrderItem>[];
                  var res = jsonDecode(snapshot.data);

                  String event = res['event'].toString();
                  if (event.contains('orders-ws')) {
                    var data = jsonDecode(res['payload']);
                    orders = List<OrderItem>.from(
                      data.map(
                        (x) => OrderItem.fromJson(x),
                      ),
                    );
                    if (tableIndexState != 0) {
                      for (var order in orders) {
                        if (order.tableId == tableIndexState) {
                          orderList.add(order);
                        }
                      }
                    } else {
                      orderList = orders;
                    }

                    return orderList.isEmpty
                        ? SizedBox(
                            height: 200,
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
                            children:
                                orderList.map((e) => _buildItem(e)).toList(),
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
      return 4;
    }
  }

  Widget _buildItem(OrderItem order) {
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
              _buildFooter(context, order),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, OrderItem order) {
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CommonIconButton(
              onTap: () {
                AppDialog.showWarningDialog(context,
                    title: 'Hủy đơn',
                    description: 'Bạn có muốn huỷ đơn ${order.id}?',
                    onPressedComfirm: () {
                  order = order.copyWith(status: 'cancel');
                  _handleUpdateOrder(order);
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
                  order = order.copyWith(status: 'processing');
                  _handleUpdateOrder(order);
                });
              },
              icon: Icons.check,
              color: AppColors.islamicGreen,
            ),
          ],
        ),
      ],
    );
  }

  void _handleUpdateOrder(OrderItem orderItem) {
    context.read<OrderBloc>().add(OrderUpdated(order: orderItem));
    context.pop();
  }

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
                'chien ham, them cai deo gi do vao day nhe,chien ham, them cai deo gi do vao day nhe,',
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
