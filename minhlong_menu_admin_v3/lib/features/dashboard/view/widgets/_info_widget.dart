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
    return ListView(
      scrollDirection: Axis.horizontal,
      children: [
        _buildItemInfo(
          backgroundColor: Colors.pink.shade100,
          icon: Icons.receipt_rounded,
          title: 'Tổng đơn hoàn thành',
          value: infoModel.orderCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.green.shade100,
          icon: Icons.receipt_rounded,
          title: 'Tổng đơn hoàn thành',
          value: infoModel.orderCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.cyan.shade100,
          icon: Icons.receipt_rounded,
          title: 'Tổng đơn hoàn thành',
          value: infoModel.orderCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.purple.shade100,
          icon: Icons.receipt_rounded,
          title: 'Tổng đơn hoàn thành',
          value: infoModel.orderCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.blue.shade100,
          icon: Icons.fastfood_rounded,
          title: 'Số lượng món ăn',
          value: infoModel.foodCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.red.shade100,
          icon: Icons.table_restaurant,
          title: 'Tổng số bàn',
          value: infoModel.tableCount.toString(),
        ),
        20.horizontalSpace,
        _buildItemInfo(
          backgroundColor: Colors.orange.shade100,
          icon: Icons.category_rounded,
          title: 'Tổng số danh mục',
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

  Widget _buildItemInfo(
      {required Color backgroundColor,
      required IconData icon,
      required String title,
      required String value}) {
    return Card(
      color: backgroundColor,
      child: Container(
        width: 180,
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
                        style: kBodyStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.secondTextColor,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        value,
                        style: kHeadingStyle.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
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
}
