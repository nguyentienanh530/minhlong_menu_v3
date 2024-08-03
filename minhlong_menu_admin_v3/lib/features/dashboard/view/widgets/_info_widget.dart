part of '../screens/dashboard_screen.dart';

extension _InfoWidget on _DashboardViewState {
  Widget _buildInfoWidget() {
    return BlocBuilder<InfoBloc, InfoState>(
      builder: (context, state) {
        return (switch (state) {
          InfoInitial() => _buildLoading(),
          InfoFetchInProgress() => _buildLoading(),
          InfoFetchSuccess() => _buildInfoFetchSuccess(state.info),
          InfoFetchFailure() => ErrWidget(error: state.message),
        });
      },
    );
  }

  Widget _buildInfoFetchSuccess(InfoModel infoModel) {
    double percentProfit = 0.0;

    if (infoModel.revenueOnYesterday != 0) {
      percentProfit = ((infoModel.revenueToday - infoModel.revenueOnYesterday) /
              infoModel.revenueOnYesterday) *
          100;
    } else {
      if (infoModel.revenueToday != 0) {
        percentProfit = 100;
      }
    }
// infoModel.revenueToday
    return ListView(
      // physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      children: [
        _buildItemInfo(
            backgroundColor: Colors.white60,
            icon: Icons.payment,
            title: 'Doanh thu ngày',
            value: '${Ultils.currencyFormat(infoModel.revenueToday)} đ',
            percent: true,
            percentValue: percentProfit),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.green.shade100,
          icon: Icons.credit_score_rounded,
          title: 'Doanh thu hôm qua',
          value: '${Ultils.currencyFormat(infoModel.revenueOnYesterday)} đ',
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.cyan.shade100,
          icon: Icons.paid_rounded,
          title: 'Tổng doanh thu',
          value: '${Ultils.currencyFormat(infoModel.totalRevenue)} đ',
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.purple.shade100,
          icon: Icons.receipt_rounded,
          title: 'Đơn hoàn thành',
          value: '${infoModel.orderCount}',
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.blue.shade100,
          icon: Icons.fastfood_rounded,
          title: 'Món ăn',
          value: infoModel.foodCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.red.shade100,
          icon: Icons.table_restaurant,
          title: 'Bàn ăn',
          value: infoModel.tableCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.orange.shade100,
          icon: Icons.category_rounded,
          title: 'Danh mục',
          value: infoModel.categoryCount.toString(),
        ),
      ],
    );
  }

  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildItemInfo({
    required Color backgroundColor,
    required IconData icon,
    required String title,
    required String value,
    bool percent = false,
    double? percentValue,
  }) {
    return Card(
      elevation: 1,
      color: backgroundColor,
      child: Container(
        width: 160,
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            LayoutBuilder(
              builder: (context, constraints) {
                return Card(
                  elevation: 10,
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: Icon(
                      icon,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(
              width: defaultPadding / 2,
            ),
            const Spacer(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        title,
                        style: context.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w700,
                          color: Colors.black.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        children: [
                          Text(
                            value,
                            style: context.titleStyleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          10.horizontalSpace,
                          percent
                              ? _buildPercentProfit(percent: percentValue!)
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            10.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildPercentProfit({required double percent}) {
    return (switch (percent) {
      > 0.0 => Row(
          children: [
            const Icon(Icons.arrow_upward, size: 10, color: Colors.green),
            Text(
              '${Ultils.currencyFormat(percent)}%',
              style: context.bodyMedium!.copyWith(
                fontSize: 10,
                color: Colors.green,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      < 0.0 => Row(
          children: [
            const Icon(Icons.arrow_downward, size: 10, color: Colors.red),
            Text(
              '${Ultils.currencyFormat(percent).replaceFirst('-', '')}%',
              style: context.bodyMedium!.copyWith(
                fontSize: 10,
                color: Colors.red,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      == 0 => Row(
          children: [
            const Icon(Icons.arrow_back, size: 10, color: Colors.orange),
            Text(
              '${Ultils.currencyFormat(percent)}%',
              style: context.bodyMedium!.copyWith(
                fontSize: 10,
                color: Colors.orange,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      _ => Container(),
    });
  }
}
