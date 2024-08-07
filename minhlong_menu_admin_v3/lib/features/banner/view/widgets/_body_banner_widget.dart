part of '../screens/banner_screen.dart';

extension _BodyBannerWidget on _BannerViewState {
  Widget _bodyBannerWidget() {
    return Container(
      padding: const EdgeInsets.all(5).r,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(defaultBorderRadius).r,
      ),
      child: _bannerWidget(),
    );
  }

  Widget _bannerWidget() {
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
          child: BlocListener<BannerBloc, BannerState>(
            listener: (context, state) {
              if (state is BannerDeleteInProgress) {
                AppDialog.showLoadingDialog(context);
              }
              if (state is BannerDeleteSuccess) {
                Navigator.pop(context);
                OverlaySnackbar.show(context, 'Xoá thành công');
                _fechData(page: _curentPage.value, limit: _limit.value);
              }
              if (state is BannerDeleteFailure) {
                Navigator.pop(context);
                OverlaySnackbar.show(context, state.errorMessage,
                    type: OverlaySnackbarType.error);
              }
            },
            child: Builder(builder: (context) {
              var bannerState = context.watch<BannerBloc>().state;
              switch (bannerState) {
                case BannerFetchSuccess():
                  context
                      .read<PaginationCubit>()
                      .setPagination(bannerState.bannerModel.paginationModel!);
                  return SingleChildScrollView(
                      child: _buildWidgetSuccess(bannerState.bannerModel));

                case BannerFetchFailure():
                  return ErrWidget(error: bannerState.errorMessage);

                case BannerFetchInProgress():
                  return const Loading();

                case BannerFetchEmpty():
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
                        child: ValueListenableBuilder<BannerModel>(
                          valueListenable: _bannerValueNotifier,
                          builder: (context, order, child) {
                            return ValueListenableBuilder(
                              valueListenable: _limit,
                              builder: (context, limit, child) => Text(
                                'Hiển thị 1 đến $limit trong số ${pagination.totalItem} banner',
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
                          _fechData(limit: _limit.value, page: pageNumber);
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

  Widget _buildWidgetSuccess(BannerModel banner) {
    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(100),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: banner.bannerItems
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

  TableRow _buildRowTable(int index, BannerItem bannerItem) {
    final isShowBanner = ValueNotifier(bannerItem.show);
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
          child: Container(
            height: 60.h,
            width: 60.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(textFieldBorderRadius).r),
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: '${ApiConfig.host}${bannerItem.image}',
              fit: BoxFit.contain,
              errorWidget: errorBuilderForImage,
            ),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            bannerItem.image.split('/').last,
            style: context.bodyMedium!
                .copyWith(color: context.bodyMedium!.color!.withOpacity(0.5)),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: ValueListenableBuilder(
            valueListenable: isShowBanner,
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
                  value: isShowBanner.value ?? false,
                  onChanged: (value) {
                    isShowBanner.value = value;
                    BannerApi(dio: dio).updateBanner(
                        banner: bannerItem.copyWith(
                      show: value,
                    ));
                  });
            },
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
                  _showCreateOrUpdateBannerDialog(
                      type: ScreenType.update, bannerItem: bannerItem);
                },
                icon: Icons.edit,
                color: Colors.orange,
                tooltip: 'Chỉnh sửa',
              ),
            ),
            10.horizontalSpace,
            Container(
              height: 70.h,
              alignment: Alignment.center,
              child: CommonIconButton(
                onTap: () {
                  AppDialog.showWarningDialog(
                    context,
                    title: 'Xóa Banner',
                    description: 'Xóa ${bannerItem.image}?',
                    confirmText: 'Xác nhận',
                    haveCancelButton: true,
                    onPressedComfirm: () {
                      _handleDeleteBanner(tableID: bannerItem.id);
                    },
                  );
                  // showDialog(
                  //   context: context,
                  //   builder: (context) => AppDialog(
                  //     title: 'Xóa Banner',
                  //     description: 'Xóa ${bannerItem.image}?',
                  //     confirmText: 'Xác nhận',
                  //     onTap: () {
                  //       _handleDeleteBanner(tableID: bannerItem.id);
                  //     },
                  //   ),
                  // );
                },
                icon: Icons.delete_outline,
                color: Colors.red,
                tooltip: 'Xóa',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future<void> _showCreateOrUpdateBannerDialog(
      {required ScreenType type, BannerItem? bannerItem}) async {
    await showDialog(
        context: context,
        builder: (context) => BlocProvider(
              create: (context) => BannerBloc(
                  bannerRepository: context.read<BannerRepository>()),
              child: Dialog(
                child: CreateOrUpdateBanner(
                  type: type,
                  bannItem: bannerItem,
                ),
              ),
            )).then(
      (value) {
        if (value != null && value is bool) {
          if (value) {
            _fechData(page: _curentPage.value, limit: _limit.value);
          }
        }
      },
    );
  }

  void _handleDeleteBanner({required int tableID}) {
    context.pop();
    context.read<BannerBloc>().add(BannerDeleted(id: tableID));
  }
}
