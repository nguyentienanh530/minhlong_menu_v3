part of '../screens/category_screen.dart';

extension _FoodBodyWidget on _CategoryViewState {
  Widget _bodyCategoryWidget() {
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
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildRowTitle(),
            ],
          ),
        ),
        Expanded(
          child: BlocListener<CategoryBloc, CategoryState>(
            listener: (context, state) {
              if (state is CategoryDeleteInProgress) {
                AppDialog.showLoadingDialog(context);
              }
              if (state is CategoryDeleteSuccess) {
                Navigator.pop(context);
                OverlaySnackbar.show(context, 'Xoá thành công');
                _fetchCategory(page: _curentPage.value, limit: _limit.value);
              }
              if (state is CategoryDeleteFailure) {
                Navigator.pop(context);
                OverlaySnackbar.show(context, state.message,
                    type: OverlaySnackbarType.error);
              }
            },
            child: Builder(builder: (context) {
              var categoryState = context.watch<CategoryBloc>().state;
              switch (categoryState) {
                case CategoryFetchSuccess():
                  context.read<PaginationCubit>().setPagination(
                      categoryState.categoryModel.paginationModel!);
                  return SingleChildScrollView(
                      child: _buildWidgetSuccess(categoryState.categoryModel));

                case CategoryFetchFailure():
                  return ErrWidget(error: categoryState.message);

                case CategoryFetchInProgress():
                  return const Loading();

                case CategoryFetchEmpty():
                  return Center(
                    child: Text(
                      'Không có dữ liệu',
                      style: context.bodyMedium!
                          .copyWith(color: context.bodyMedium!.color),
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
                        child: ValueListenableBuilder<CategoryModel>(
                          valueListenable: _categoryValueNotifier,
                          builder: (context, order, child) {
                            return ValueListenableBuilder(
                              valueListenable: _limit,
                              builder: (context, limit, child) => Text(
                                'Hiển thị 1 đến $limit trong số ${pagination.totalItem} món',
                                style: context.bodyMedium!.copyWith(
                                  color: context.bodyMedium!.color,
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
                          _fetchCategory(limit: _limit.value, page: pageNumber);
                        },
                        fontSize: 16,
                        buttonElevation: 10,
                        buttonRadius: textFieldBorderRadius,
                        pageTotal: pagination.totalPage,
                        pageInit: _curentPage.value,
                        colorPrimary: context.colorScheme.primary,
                        colorSub: context.colorScheme.surface,
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

  Widget _buildWidgetSuccess(CategoryModel categoryModel) {
    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(100),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: categoryModel.categoryItems
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

  TableRow _buildRowTable(int index, CategoryItem categoryItem) {
    return TableRow(
      decoration: BoxDecoration(
        color: index.isEven
            ? context.colorScheme.surface
            : context.colorScheme.onSecondaryContainer.withOpacity(0.1),
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
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: '${ApiConfig.host}${categoryItem.image}',
              fit: BoxFit.contain,
              errorWidget: errorBuilderForImage,
            ),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            categoryItem.name,
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            categoryItem.serial.toString(),
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
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
                  _showCreateOrUpdateCategoryDialog(
                      type: ScreenType.update, categoryItem: categoryItem);
                },
                icon: Icons.edit,
                color: context.colorScheme.primary,
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
                      title: 'Xóa Danh mục',
                      description: 'Xóa danh mục ${categoryItem.name}?',
                      confirmText: 'Xác nhận', onPressedComfirm: () {
                    _handleDeleteCategory(categoryID: categoryItem.id);
                  });
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AppDialog(
                  //     title: 'Xóa Danh mục',
                  //     description: 'Xóa danh mục ${categoryItem.name}?',
                  //     confirmText: 'Xác nhận',
                  //     onTap: () {
                  //       _handleDeleteCategory(categoryID: categoryItem.id);
                  //     },
                  //   ),
                  // );
                },
                icon: Icons.delete_outline,
                color: Colors.red,
                tooltip: 'Xóa Danh mục',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showCreateOrUpdateCategoryDialog(
      {required ScreenType type, CategoryItem? categoryItem}) async {
    await showDialog(
        context: context,
        builder: (context) => BlocProvider(
              create: (context) => CategoryBloc(
                  categoryRepository: context.read<CategoryRepository>()),
              child: Dialog(
                child: CreateOrUpdateCategory(
                  type: type,
                  categoryItem: categoryItem,
                ),
              ),
            )).then(
      (value) {
        if (value != null && value is bool) {
          if (value) {
            _fetchCategory(page: _curentPage.value, limit: _limit.value);
          }
        }
      },
    );
  }

  void _handleDeleteCategory({required int categoryID}) {
    context.pop();
    context.read<CategoryBloc>().add(CategoryDeleted(categoryID));
  }
}
