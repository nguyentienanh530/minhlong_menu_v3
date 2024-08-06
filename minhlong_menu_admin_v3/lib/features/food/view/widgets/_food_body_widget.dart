part of '../screens/food_screen.dart';

extension _FoodBodyWidget on _FoodViewState {
  Widget _foodBodyWidget() {
    return Container(
      padding: const EdgeInsets.all(5).r,
      decoration: BoxDecoration(
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
              5: FlexColumnWidth(),
              6: FixedColumnWidth(100),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildRowTitle(),
            ],
          ),
        ),
        Expanded(
          child: BlocListener<FoodBloc, FoodState>(
            listener: (context, state) {
              if (state is FoodDeleteInProgress) {
                AppDialog.showLoadingDialog(context);
              }
              if (state is FoodDeleteSuccess) {
                _overlayShown = false;
                Navigator.pop(context);
                OverlaySnackbar.show(context, 'Xoá thành công');
                _fetchData(page: _curentPage.value, limit: _limit.value);
              }
              if (state is FoodDeleteFailure) {
                _overlayShown = false;
                Navigator.pop(context);
                OverlaySnackbar.show(context, state.message,
                    type: OverlaySnackbarType.error);
              }
            },
            child: Builder(builder: (context) {
              var foodsState = context.watch<FoodBloc>().state;
              switch (foodsState) {
                case FoodFetchSuccess():
                  _overlayShown = false;
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
                      style: context.bodyMedium!.copyWith(
                          color: context.bodyMedium!.color!.withOpacity(0.5)),
                    ),
                  );

                default:
                  return const SizedBox();
              }
            }),
          ),
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
          width: context.sizeDevice.width,
          height: 71,
          padding: const EdgeInsets.all(10).r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              context.isMobile
                  ? const SizedBox()
                  : FittedBox(
                      alignment: Alignment.centerLeft,
                      fit: BoxFit.scaleDown,
                      child: ValueListenableBuilder<FoodModel>(
                        valueListenable: _foodModel,
                        builder: (context, order, child) {
                          return ValueListenableBuilder(
                            valueListenable: _limit,
                            builder: (context, limit, child) => Text(
                              'Hiển thị 1 đến $limit trong số ${pagination.totalItem} món',
                              style: context.bodyMedium!.copyWith(
                                color:
                                    context.bodyMedium!.color!.withOpacity(0.5),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _curentPage,
                  builder: (context, value, child) {
                    return NumberPagination(
                      onPageChanged: (int pageNumber) {
                        _curentPage.value = pageNumber;

                        _fetchData(page: pageNumber, limit: _limit.value);
                      },
                      fontSize: 14,
                      threshold: 5,
                      buttonRadius: textFieldBorderRadius,
                      pageTotal: pagination.totalPage,
                      pageInit: _curentPage.value,
                      colorPrimary: context.colorScheme.primary,
                      colorSub: context.colorScheme.surface,
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
          5: FlexColumnWidth(),
          6: FixedColumnWidth(100),
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
                style: context.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: context.bodyMedium!.color!.withOpacity(0.8)),
              ))
          .toList(),
    );
  }

  TableRow _buildRowTable(int index, FoodItem foodItem) {
    final isShowFood = ValueNotifier(foodItem.isShow);
    return TableRow(
      decoration: BoxDecoration(
        color: index.isEven
            ? Colors.transparent
            : context.colorScheme.primary.withOpacity(0.05),
      ),
      children: <Widget>[
        Container(
          height: 70,
          alignment: Alignment.center,
          child: SizedBox(
            height: 60.h,
            width: 60.h,
            child: ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(textFieldBorderRadius).r,
              child: CachedNetworkImage(
                imageUrl: '${ApiConfig.host}${foodItem.image1 ?? ''}',
                fit: BoxFit.cover,
                errorWidget: errorBuilderForImage,
              ),
            ),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            foodItem.name,
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            foodItem.categoryName,
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            Ultils.currencyFormat(foodItem.price ?? 0.0),
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            '${foodItem.discount ?? 0}%',
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: ValueListenableBuilder(
            valueListenable: isShowFood,
            builder: (context, value, child) {
              return Switch(
                  activeColor: context.colorScheme.primary,
                  inactiveThumbColor:
                      context.colorScheme.onPrimaryContainer.withOpacity(0.8),
                  inactiveTrackColor:
                      context.colorScheme.onPrimaryContainer.withOpacity(0.1),
                  activeTrackColor:
                      context.colorScheme.primary.withOpacity(0.3),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  dragStartBehavior: DragStartBehavior.start,
                  hoverColor: Colors.white54,
                  trackOutlineWidth: const WidgetStatePropertyAll(0),
                  trackOutlineColor:
                      const WidgetStatePropertyAll(Colors.transparent),
                  value: isShowFood.value ?? false,
                  onChanged: (value) {
                    isShowFood.value = value;
                    FoodApi(dio).updateFood(
                        food: foodItem.copyWith(
                      isShow: value,
                    ));
                  });
            },
          ),
        ),
        Row(
          children: [
            Container(
              height: 70.h,
              alignment: Alignment.center,
              child: CommonIconButton(
                onTap: () {
                  _showCreateOrUpdateDialog(
                      mode: ScreenType.update, foodItem: foodItem);
                },
                icon: Icons.edit,
                color: Colors.yellow.shade700,
                tooltip: 'Chỉnh sửa',
              ),
            ),
            10.horizontalSpace,
            Container(
              height: 70.h,
              alignment: Alignment.center,
              child: CommonIconButton(
                onTap: () {
                  AppDialog.showWarningDialog(context,
                      title: 'Xóa món',
                      description: 'Xóa món ${foodItem.name}?',
                      confirmText: 'Xác nhận', onPressedComfirm: () {
                    _handleDeleteFood(orderID: foodItem.id);
                  });
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AppDialog(
                  //     title: 'Xóa món',
                  //     description: 'Xóa món ${foodItem.name}?',
                  //     confirmText: 'Xác nhận',
                  //     onTap: () {
                  //       _handleDeleteFood(orderID: foodItem.id);
                  //     },
                  //   ),
                  // );
                },
                icon: Icons.delete_outline,
                color: Colors.red,
                tooltip: 'Xóa món',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showCreateOrUpdateDialog(
      {required ScreenType mode, FoodItem? foodItem}) async {
    await showDialog(
        context: context,
        builder: (context) => BlocProvider(
              create: (context) => FoodBloc(context.read<FoodRepository>()),
              child: Dialog(
                child: CreateOrUpdateFoodDialog(
                  mode: mode,
                  foodItem: foodItem,
                ),
              ),
            )).then(
      (value) {
        if (value != null && value is bool) {
          if (value) {
            _fetchData(page: _curentPage.value, limit: _limit.value);
          }
        }
      },
    );
  }

  void _handleDeleteFood({required int orderID}) {
    context.pop();
    context.read<FoodBloc>().add(FoodDeleted(id: orderID));
  }
}
