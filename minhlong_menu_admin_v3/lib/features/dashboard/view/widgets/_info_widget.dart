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
    return GridView(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 16 / 6,
      ),
      children: [
        _buildItemInfo(
          icon: Icons.receipt_rounded,
          title: 'Tổng đơn hoàn thành',
          value: infoModel.orderCount.toString(),
        ),
        _buildItemInfo(
          icon: Icons.fastfood_rounded,
          title: 'Số lượng món ăn',
          value: infoModel.foodCount.toString(),
        ),
        _buildItemInfo(
          icon: Icons.table_bar,
          title: 'Tổng số bàn',
          value: infoModel.tableCount.toString(),
        ),
        _buildItemInfo(
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
      {required IconData icon, required String title, required String value}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding / 2),
        child: Row(
          children: [
            Expanded(child: LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  height: constraints.maxWidth,
                  width: constraints.maxWidth,
                  child: CommonIconButton(
                    onTap: null,
                    icon: icon,
                  ),
                );
              },
            )),
            const SizedBox(
              width: defaultPadding / 2,
            ),
            Expanded(
              flex: 3,
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
          ],
        ),
      ),
    );
  }
}
