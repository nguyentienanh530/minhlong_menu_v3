part of '../screens/dinner_table_screen.dart';

extension _FoodBodyWidget on _DinnerTableViewState {
  Widget _bodyDinnerTableWidget() {
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
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildRowTitle(),
            ],
          ),
        ),
        Expanded(
          child: BlocListener<DinnerTableBloc, DinnerTableState>(
            listener: (context, state) {
              if (state is DinnerTableDeleteInProgress) {
                AppDialog.showLoadingDialog(context);
              }
              if (state is DinnerTableDeleteSuccess) {
                Navigator.pop(context);
                OverlaySnackbar.show(context, 'Xoá thành công');
                _fetchDateDinnerTable(
                    page: _curentPage.value, limit: _limit.value);
              }
              if (state is DinnerTableFailure) {
                Navigator.pop(context);
                OverlaySnackbar.show(context, state.message,
                    type: OverlaySnackbarType.error);
              }
            },
            child: Builder(builder: (context) {
              var dinnerTableState = context.watch<DinnerTableBloc>().state;
              switch (dinnerTableState) {
                case DinnerTableSuccess():
                  context.read<PaginationCubit>().setPagination(
                      dinnerTableState.tableModel.paginationModel!);
                  return SingleChildScrollView(
                      child: _buildWidgetSuccess(dinnerTableState.tableModel));

                case DinnerTableFailure():
                  return ErrWidget(error: dinnerTableState.message);

                case DinnerTableInprogress():
                  return const Loading();

                case DinnerTableEmpty():
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
                        child: ValueListenableBuilder<TableModel>(
                          valueListenable: _dinnerTableValueNotifier,
                          builder: (context, order, child) {
                            return ValueListenableBuilder(
                              valueListenable: _limit,
                              builder: (context, limit, child) => Text(
                                'Hiển thị 1 đến $limit trong số ${pagination.totalItem} món',
                                style: kBodyStyle.copyWith(
                                  color: AppColors.secondTextColor,
                                ),
                              ),
                            );
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

                          // _fetchData(page: pageNumber, limit: _limit.value);
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

  Widget _buildWidgetSuccess(TableModel tables) {
    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(100),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: tables.tableItems
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

  TableRow _buildRowTable(int index, TableItem tableItem) {
    return TableRow(
      decoration: BoxDecoration(
        color:
            index.isEven ? AppColors.black.withOpacity(0.1) : AppColors.white,
      ),
      children: <Widget>[
        Container(
            height: 70,
            alignment: Alignment.center,
            child: Text(
              '${tableItem.id}',
              style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
            )),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            tableItem.name,
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            tableItem.seats.toString(),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            tableItem.isUse ? 'Đang sử dụng' : 'Không sử dụng',
            style: kBodyStyle.copyWith(
              color: tableItem.isUse ? AppColors.islamicGreen : AppColors.red,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 70.h,
              alignment: Alignment.center,
              child: CommonIconButton(
                onTap: () {
                  // _showCreateOrUpdateDialog(
                  //     mode: FoodScreenMode.update, foodItem: foodItem);
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
                  showDialog(
                    context: context,
                    builder: (context) => AppDialog(
                      title: 'Xóa bàn',
                      description: 'Xóa bàn ${tableItem.name}?',
                      confirmText: 'Xác nhận',
                      onTap: () {
                        _handleDeleteDinnerTable(tableID: tableItem.id);
                      },
                    ),
                  );
                },
                icon: Icons.delete_outline,
                color: AppColors.red,
                tooltip: 'Xóa bàn',
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Future<void> _showCreateOrUpdateDialog(
  //     {required FoodScreenMode mode, FoodItem? foodItem}) async {
  //   await showDialog(
  //       context: context,
  //       builder: (context) => Dialog(
  //             backgroundColor: AppColors.background,
  //             child: CreateOrUpdateFoodDialog(
  //               mode: mode,
  //               foodItem: foodItem,
  //             ),
  //           )).then(
  //     (value) {
  //       if (value != null && value is bool) {
  //         if (value) {
  //           // _fetchData(page: _curentPage.value, limit: _limit.value);
  //         }
  //       }
  //     },
  //   );
  // }

  void _handleDeleteDinnerTable({required int tableID}) {
    context.pop();
    context.read<DinnerTableBloc>().add(DinnerTableDeleted(id: tableID));
  }
}