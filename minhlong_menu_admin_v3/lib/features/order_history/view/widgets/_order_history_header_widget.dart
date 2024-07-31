part of '../screens/order_history_screen.dart';

extension _OrderHeaderWidget on _OrderViewState {
  Widget get _orderHeaderWidget => SizedBox(
        // height: 80.h,
        width: double.infinity,
        child: context.isDesktop || context.is4k
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTabbarWidget(),
                  10.horizontalSpace,
                  _buildDatePicker(),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTabbarWidget(),
                  10.verticalSpace,
                  _buildDatePicker(),
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
        controller: _tabController,
        splashFactory: InkSplash.splashFactory,
        labelStyle: kBodyStyle.copyWith(
            color: AppColors.white, fontWeight: FontWeight.w900),
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
          Tab(text: 'Hoàn thành'),
          Tab(text: 'Bị hủy'),
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

  Widget _buildDatePicker() {
    return ListenableBuilder(
        listenable: _datePicker,
        builder: (context, _) {
          return Row(
            children: [
              const IconButton(
                  onPressed: null, icon: Icon(Icons.calendar_month)),
              Container(
                  height: 35,
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultPadding),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(textFieldBorderRadius).r,
                      color: AppColors.white),
                  child: InkWell(
                      onTap: () async {
                        final DateTime? picked = await showDatePicker(
                            context: context,
                            locale: const Locale('vi'),
                            initialEntryMode: DatePickerEntryMode.calendar,
                            initialDate: _datePicker.value,
                            firstDate: DateTime(2015, 8),
                            lastDate: DateTime(2101));
                        if (picked != null && picked != _datePicker.value) {
                          _datePicker.value = picked;
                          _curentPage.value = 1;
                          _fetchData(
                              status: _listStatus[_tabController.index],
                              page: 1,
                              date: _datePicker.value.toString(),
                              limit: _limit.value);
                        }
                      },
                      child: Text(Ultils.formatDateToString(
                          _datePicker.value.toString(),
                          isShort: true)))),
              10.horizontalSpace,
              _buildDropdown(),
              10.horizontalSpace,
              IconButton(
                onPressed: () {
                  _datePicker.value = DateTime.now();
                  _curentPage.value = 1;
                  _limit.value = 10;
                  _fetchData(
                      status: _listStatus[_tabController.index],
                      page: 1,
                      date: null,
                      limit: _limit.value);
                },
                icon: const Icon(Icons.refresh),
                tooltip: 'Đặt lại',
              ),
            ],
          );
        });
  }
}
