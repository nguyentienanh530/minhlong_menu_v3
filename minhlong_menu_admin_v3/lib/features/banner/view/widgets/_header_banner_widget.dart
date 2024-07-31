part of '../screens/banner_screen.dart';

extension _HeaderCategoryWidget on _BannerViewState {
  Widget get _headerBannerWidget => SizedBox(
        // height: 80.h,
        width: double.infinity,
        child: context.isMobile
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    _buildDropdown(),
                    10.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        16.horizontalSpace,
                        Expanded(
                          child: _buildButtonAdd(),
                        )
                      ],
                    ),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  10.horizontalSpace,
                  _buildDropdown(),
                  30.horizontalSpace,
                  _buildButtonAdd(),
                  30.horizontalSpace,
                ],
              ),
      );

  Widget _buildDropdown() {
    return Container(
        height: 35,
        width: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: AppColors.white,
        ),
        child: ValueListenableBuilder(
          valueListenable: _limit,
          builder: (context, limit, child) {
            return DropdownButton(
              padding: const EdgeInsets.all(0),
              // isExpanded: true,
              value: limit.toString(),
              icon: const Icon(Icons.arrow_drop_down),
              borderRadius: BorderRadius.circular(defaultBorderRadius).r,
              underline: const SizedBox(),
              style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
              dropdownColor: AppColors.white,
              items: itemsDropdown,
              onChanged: (value) {
                _limit.value = int.parse(value.toString());
                _curentPage.value = 1;
                // _fetchDateDinnerTable(limit: _limit.value, page: 1);
              },
            );
          },
        ));
  }

  _buildButtonAdd() {
    return InkWell(
      onTap: () async {
        _showCreateOrUpdateBannerDialog(type: ScreenType.create);
      },
      child: Container(
        height: 35,
        width: 130.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: context.colorScheme.primary,
        ),
        child: Text(
          'Thêm',
          style: kBodyStyle.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
