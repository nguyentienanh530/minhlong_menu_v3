part of '../screens/order_screen.dart';

extension _OrderHeaderWidget on _OrderViewState {
  Widget get _orderHeaderWidget => SizedBox(
        // height: 80.h,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTabbarWidget(),
            10.horizontalSpace,
            _buildDropdown(),
            _buildAddOrder()
          ],
        ),
      );

  Widget _buildTabbarWidget() {
    return Container(
      height: 35,
      width: 300,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
          color: AppColors.white),
      child: TabBar(
        // isScrollable: context.isMobile ? true : false,
        controller: _tabController,
        splashFactory: InkSplash.splashFactory,
        labelStyle: kBodyStyle.copyWith(color: AppColors.white),
        indicatorSize: TabBarIndicatorSize.tab,
        indicator: BoxDecoration(
            borderRadius: BorderRadius.circular(textFieldBorderRadius),
            color: AppColors.themeColor),
        unselectedLabelStyle:
            kBodyStyle.copyWith(color: AppColors.secondTextColor),
        splashBorderRadius: BorderRadius.circular(textFieldBorderRadius),
        onTap: (value) {
          _fetchData(
              status: _listStatus[_tabController.index],
              page: 1,
              limit: _limit.value);
        },
        tabs: const [
          Tab(text: 'Mới'),
          Tab(text: 'Đang làm'),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
        height: 35,
        width: 100,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: AppColors.white,
        ),
        child: ValueListenableBuilder(
          valueListenable: _limit,
          builder: (context, limit, child) {
            return DropdownButton(
              padding: const EdgeInsets.all(0),
              value: limit.toString(),
              icon: const Icon(Icons.arrow_drop_down),
              borderRadius: BorderRadius.circular(defaultBorderRadius).r,
              underline: const SizedBox(),
              style: const TextStyle(color: AppColors.secondTextColor),
              dropdownColor: AppColors.white,
              items: itemsDropdown,
              onChanged: (value) {
                _limit.value = int.parse(value.toString());
                _curentPage.value = 1;
                _fetchData(
                  status: _listStatus[_tabController.index],
                  page: 1,
                  limit: limit,
                );
              },
            );
          },
        ));
  }

  Widget _buildAddOrder() {
    return ElevatedButton(
        onPressed: () => context.push(AppRoute.createOrUpdateOrder),
        style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(AppColors.themeColor),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(textFieldBorderRadius)))),
        child: const Text(
          'Thêm',
          style: kButtonWhiteStyle,
        ));
  }
}
