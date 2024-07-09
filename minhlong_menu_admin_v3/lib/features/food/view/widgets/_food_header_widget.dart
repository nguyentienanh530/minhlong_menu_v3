part of '../screens/food_screen.dart';

extension _FoodHeaderWidget on _FoodViewState {
  Widget get _foodHeaderWidget => SizedBox(
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
                        Expanded(flex: 3, child: _buildSearch()),
                        16.horizontalSpace,
                        Expanded(
                          child: _buildButtonAddFood(),
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
                  _buildSearch(),
                  30.horizontalSpace,
                  _buildButtonAddFood(),
                  30.horizontalSpace,
                ],
              ),
      );

  Widget _buildDropdown() {
    return Container(
        height: 35,
        width: 100.h,
        // padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
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
              value: limit.toString(),
              icon: const Icon(Icons.arrow_drop_down),
              borderRadius: BorderRadius.circular(defaultBorderRadius).r,
              underline: const SizedBox(),
              style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
              dropdownColor: AppColors.white,
              items: itemsDropdown,
              onChanged: (value) {
                _limit.value = int.parse(value.toString());
                _fetchData(
                  page: 1,
                  limit: _limit.value,
                );
              },
            );
          },
        ));
  }

  Widget _buildSearch() {
    // return Container(
    //   height: 35,
    //   width: 400.h,
    //   alignment: Alignment.center,
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(8).r,
    //     color: AppColors.white,
    //   ),
    //   child: TextField(
    //     // controller: _searchController,
    //     onChanged: (value) {
    //       // _fetchData(
    //       //   status: _listStatus[_tabController.index],
    //       //   page: 1,
    //       //   limit: _limit.value,
    //       //   search: value
    //       // );
    //     },
    //     style: kBodyStyle,
    //     decoration: InputDecoration(
    //       floatingLabelAlignment: FloatingLabelAlignment.center,
    //       isDense: true,
    //       contentPadding: const EdgeInsets.all(10),
    //       border: InputBorder.none,
    //       hintText: 'Tìm kiếm',
    //       hintStyle: kBodyStyle.copyWith(color: AppColors.secondTextColor),
    //       prefixIcon:
    //           const Icon(Icons.search, color: AppColors.secondTextColor),
    //     ),
    //   ),
    // );

    return Container(
      height: 35,
      width: 400.h,
      alignment: Alignment.center,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(8).r,
      //   color: AppColors.white,
      // ),
      child: SearchAnchor(
        isFullScreen: false,
        builder: (context, controller) {
          return SearchBar(
              controller: controller,
              hintText: 'Tìm kiếm',
              hintStyle: WidgetStatePropertyAll(
                  kCaptionStyle.copyWith(color: AppColors.secondTextColor)),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
                ),
              ),
              leading:
                  const Icon(Icons.search, color: AppColors.secondTextColor),
              onTap: () {
                controller.openView();
              },
              onChanged: (value) {
                print('changed $value');
                controller.openView();
              });
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        },
      ),
    );
  }

  _buildButtonAddFood() {
    return InkWell(
      onTap: () async {
        _showCreateOrUpdateDialog(mode: FoodScreenMode.create);
      },
      child: Container(
        height: 35,
        width: 130.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8).r,
          color: AppColors.themeColor,
        ),
        child: Text(
          'Thêm',
          style: kBodyStyle.copyWith(color: AppColors.white),
        ),
      ),
    );
  }
}
