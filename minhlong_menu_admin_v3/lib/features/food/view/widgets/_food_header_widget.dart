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
    return SizedBox(
      key: AppKeys.searchKey,
      height: 40,
      width: 400.h,
      child: CompositedTransformTarget(
        link: _layerLink,
        child: CommonTextField(
          filled: true,
          hintText: 'Tìm kiếm',
          controller: _searchController,
          focusNode: _focusSearch,
          onChanged: (value) async {
            _searchController.text = value;
            print('overLay: $_overlayShown');
            if (value.isNotEmpty && !_overlayShown) {
              _showOverlaySearch();
              _overlayShown = true;
            }

            context
                .read<SearchFoodBloc>()
                .add(SearchFoodStarted(query: _searchController.text));
          },
          prefixIcon:
              const Icon(Icons.search, color: AppColors.secondTextColor),
          suffixIcon: InkWell(
            onTap: () {
              _searchController.clear();
              context.read<SearchFoodBloc>().add(SearchFoodReset());
            },
            child: const SizedBox(
              child: Icon(Icons.clear, color: AppColors.secondTextColor),
            ),
          ),
        ),
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

  void _showOverlaySearch() {
    final overlay = Overlay.of(context);
    final renderBox =
        AppKeys.searchKey.currentContext!.findRenderObject()! as RenderBox;
    final size = renderBox.size;
    _hideOverlaySearch();
    assert(overlayEntry == null);
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        child: CompositedTransformFollower(
          showWhenUnlinked: false,
          offset: Offset(0, size.height + 8),
          link: _layerLink,
          child: Material(
            // adding transparent to apply custom border
            color: Colors.transparent,
            child: Card(
              elevation: 30,
              shadowColor: AppColors.lavender,
              child: SizedBox(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Builder(
                    builder: (context) {
                      var state = context.watch<SearchFoodBloc>().state;
                      print('state in search: $state');
                      return (switch (state) {
                        FoodSearchInProgress() => const Loading(),
                        FoodSearchSuccess() => buildListFood(state.foodItems),
                        FoodSearchFailure() => const SizedBox(),
                        FoodSearchEmpty() => Center(
                            child: Text('Không có dữ liệu',
                                style: kBodyStyle.copyWith(
                                    color: AppColors.secondTextColor))),
                        _ => const SizedBox(),
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry!);
  }

  void _hideOverlaySearch() {
    overlayEntry?.remove();
    overlayEntry?.dispose();
    overlayEntry = null;

    // _searchController.clear();
    // context.read<SearchFoodBloc>().add(SearchFoodReset());
  }

  buildListFood(List<FoodItem> foodItems) {
    print('state in search: $foodItems');
    return ListView.builder(
      itemCount: foodItems.length,
      itemBuilder: (context, index) {
        return buildFoodItem(foodItems[index]);
      },
    );
  }

  buildFoodItem(FoodItem foodItem) {
    return ListTile(
      onTap: () async {
        _hideOverlaySearch();
        _searchController.clear();
        // _focusSearch.unfocus();
        await _showCreateOrUpdateDialog(
            mode: FoodScreenMode.update, foodItem: foodItem);
      },
      title: Text(
        foodItem.name,
        style: kBodyStyle,
      ),
      leading: SizedBox(
        height: 35,
        width: 35,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8).r,
          child: CachedNetworkImage(
            imageUrl: '${ApiConfig.host}${foodItem.image1}',
            errorWidget: errorBuilderForImage,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
