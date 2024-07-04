part of '../screens/dashboard_screen.dart';

extension _OrdersOnTableWidget on _DashboardViewState {
  Widget _buildOrdersOnTable(List<OrderItem> orderList) {
    return StaggeredGrid.count(
        crossAxisCount: _gridCount(),
        children: orderList.map((e) => _buildItem(e)).toList());
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
        elevation: 4,
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
              onTap: () {},
              icon: Icons.clear_rounded,
              color: Colors.red,
              tooltip: 'Xóa đơn',
            ),
            const SizedBox(
              width: defaultPadding / 2,
            ),
            CommonIconButton(
              tooltip: 'Xác nhận đơn',
              onTap: () {},
              icon: Icons.check,
              color: AppColors.islamicGreen,
            ),
          ],
        ),
      ],
    );
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
          Ultils().formatDateToString(order.createdAt),
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
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          clipBehavior: Clip.hardEdge,
                          width: 45,
                          height: 45,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            '${ApiConfig.host}${e.photoGallery[0]}',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 10),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
