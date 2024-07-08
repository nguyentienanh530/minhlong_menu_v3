part of '../screens/food_screen.dart';

extension _FoodBodyWidget on _FoodViewState {
  Widget _foodBodyWidget() {
    return Container(
      padding: const EdgeInsets.all(5).r,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadius).r,
      ),
      child: _tableWidget(),
    );
  }

  Widget _tableWidget() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 71,
          alignment: Alignment.center,
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(100),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FixedColumnWidth(100),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildRowTitle(),
            ],
          ),
        ),
        Expanded(
          child: Builder(builder: (context) {
            var foodsState = context.watch<FoodBloc>().state;
            switch (foodsState) {
              case FoodFetchSuccess():
                context
                    .read<PaginationCubit>()
                    .setPagination(foodsState.foodModel.paginationModel!);
                return SingleChildScrollView(
                    child: _buildWidgetSuccess(foodsState.foodModel));

              case FoodFetchFailure():
                return ErrWidget(error: foodsState.message);

              case FoodFetchInProgress():
                return const Loading();

              case FoodFetchEmpty():
                return Center(
                  child: Text(
                    'Không có dữ liệu',
                    style:
                        kBodyStyle.copyWith(color: AppColors.secondTextColor),
                  ),
                );

              default:
                return const SizedBox();
            }
          }),
        ),

        _buildBottomWidget()

        // _buildBottomWidget(_orderModel.value)
      ],
    );
  }

  Widget _buildBottomWidget() {
    return Builder(
      builder: (context) {
        var pagination = context.watch<PaginationCubit>().state;
        return Container(
          width: double.infinity,
          height: 71,
          padding: const EdgeInsets.all(10).r,
          child: Row(
            children: [
              context.isMobile
                  ? const SizedBox()
                  : Expanded(
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: ValueListenableBuilder<FoodModel>(
                          valueListenable: _foodModel,
                          builder: (context, order, child) {
                            return ValueListenableBuilder(
                                valueListenable: _limit,
                                builder: (context, limit, child) => Text(
                                      'Hiển thị 1 đến $limit trong số ${pagination.totalItem} đơn',
                                      style: kBodyStyle.copyWith(
                                          color: AppColors.secondTextColor),
                                    ));
                          },
                        ),
                      ),
                    ),
              context.isDesktop ? const Spacer() : const SizedBox(),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _curentPage,
                  builder: (context, value, child) {
                    return Container(
                      alignment: Alignment.centerRight,
                      child: NumberPagination(
                        onPageChanged: (int pageNumber) {
                          _curentPage.value = pageNumber;

                          // _fetchData(
                          //     status: _listStatus[_tabController.index],
                          //     page: pageNumber,
                          //     limit: _limit.value);
                        },
                        fontSize: 16,
                        buttonElevation: 10,
                        buttonRadius: textFieldBorderRadius,
                        pageTotal: pagination.totalPage,
                        pageInit: _curentPage.value,
                        colorPrimary: AppColors.themeColor,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWidgetSuccess(FoodModel food) {
    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(100),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
          5: FixedColumnWidth(100),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: food.foodItems
            .asMap()
            .map(
                (index, value) => MapEntry(index, _buildRowTable(index, value)))
            .values
            .toList());
  }

  TableRow _buildRowTitle() {
    return TableRow(
      children: _listTitleTable
          .map((e) => Text(
                e,
                textAlign: TextAlign.center,
                style: kBodyStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.secondTextColor),
              ))
          .toList(),
    );
  }

  TableRow _buildRowTable(int index, FoodItem foodItem) {
    return TableRow(
      decoration: BoxDecoration(
        color:
            index.isEven ? AppColors.black.withOpacity(0.1) : AppColors.white,
      ),
      children: <Widget>[
        Container(
          height: 70,
          alignment: Alignment.center,
          child: Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r),
            clipBehavior: Clip.hardEdge,
            child: CachedNetworkImage(
              imageUrl: '${ApiConfig.host}${foodItem.photoGallery[0]}',
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            foodItem.name,
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            foodItem.categoryID.toString(),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.currencyFormat(foodItem.price ?? 0.0),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Switch(value: foodItem.isShow ?? false, onChanged: (value) {}),
        ),
        Row(
          children: [
            Container(
              height: 70.h,
              alignment: Alignment.center,
              child: CommonIconButton(
                onTap: () {
                  _showCreateOrUpdateDialog(foodItem);
                },
                icon: Icons.edit,
                color: AppColors.sun,
                tooltip: 'Chỉnh sửa',
              ),
            ),
            10.horizontalSpace,
            Container(
              height: 70.h,
              alignment: Alignment.center,
              child: CommonIconButton(
                onTap: () {
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AppDialog(
                  //     title: 'Xóa đơn',
                  //     description: 'Bạn có muốn xóa đơn ${orderItem.id}?',
                  //     confirmText: 'Xác nhận',
                  //     onTap: () {
                  //       // _handleDeleteOrder(orderID: orderItem.id);
                  //     },
                  //   ),
                  // );
                },
                icon: Icons.delete_outline,
                color: AppColors.red,
                tooltip: 'Xóa món',
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showCreateOrUpdateDialog(FoodItem? foodItem) {
    showDialog(
        context: context,
        builder: (context) => const Dialog(
              backgroundColor: AppColors.background,
              child: CreateOrUpdateFoodDialog(
                mode: FoodScreenMode.update,
              ),
            ));
  }
}
