part of '../screens/home_screen.dart';

extension _Body on _HomeViewState {
  Widget _buildBody() {
    return Container(
      padding: const EdgeInsets.all(5).r,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(defaultBorderRadius).r,
      ),
      child: _userTableWidget(),
    );
  }

  Widget _userTableWidget() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 71,
          alignment: Alignment.center,
          child: Table(
            columnWidths: const <int, TableColumnWidth>{
              0: FixedColumnWidth(80),
              1: FlexColumnWidth(),
              2: FlexColumnWidth(),
              3: FlexColumnWidth(),
              4: FlexColumnWidth(),
              5: FlexColumnWidth(),
              6: FlexColumnWidth(),
              7: FlexColumnWidth(),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: <TableRow>[
              _buildRowTitle(),
            ],
          ),
        ),
        Expanded(
          child: BlocListener<UserBloc, UserState>(
            listener: (context, state) {
              // if (state is BannerDeleteInProgress) {
              //   AppDialog.showLoadingDialog(context);
              // }
              // if (state is BannerDeleteSuccess) {
              //   Navigator.pop(context);
              //   OverlaySnackbar.show(context, 'Xoá thành công');
              //   _fechData(page: _curentPage.value, limit: _limit.value);
              // }
              // if (state is BannerDeleteFailure) {
              //   Navigator.pop(context);
              //   OverlaySnackbar.show(context, state.errorMessage,
              //       type: OverlaySnackbarType.error);
              // }
            },
            child: Builder(builder: (context) {
              var userState = context.watch<UsersBloc>().state;
              switch (userState) {
                case UsersFetchSuccess():
                  context
                      .read<PaginationCubit>()
                      .setPagination(userState.users.paginationModel!);
                  return SingleChildScrollView(
                      child: _buildWidgetSuccess(userState.users));

                case UsersFetchFailure():
                  return ErrWidget(error: userState.errorMessage);

                case UsersFetchInProgress():
                  return const Loading();

                case UsersFetchEmpty():
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
      ],
    );
  }

  Widget _buildWidgetSuccess(User user) {
    return Table(
        // border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FixedColumnWidth(80),
          1: FlexColumnWidth(),
          2: FlexColumnWidth(),
          3: FlexColumnWidth(),
          4: FlexColumnWidth(),
          5: FlexColumnWidth(),
          6: FlexColumnWidth(),
          7: FlexColumnWidth(),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: user.users
            .asMap()
            .map(
                (index, value) => MapEntry(index, _buildRowTable(index, value)))
            .values
            .toList());
  }

  TableRow _buildRowTitle() {
    return TableRow(
      children: _listTitleTable
          .map(
            (e) => Text(
              e,
              textAlign: TextAlign.center,
              style: kBodyStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondTextColor),
            ),
          )
          .toList(),
    );
  }

  TableRow _buildRowTable(int index, UserModel user) {
    // final isShowBanner = ValueNotifier(bannerItem.show);
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
            clipBehavior: Clip.antiAlias,
            child: CachedNetworkImage(
              imageUrl: '${ApiConfig.host}${user.image}',
              fit: BoxFit.cover,
              errorWidget: errorBuilderForImage,
            ),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            user.fullName,
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            '+84 ${user.phoneNumber}',
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            user.email,
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            user.address,
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            user.subscriptionEndDate.isEmpty
                ? ''
                : Ultils.subcriptionEndDate(user.subscriptionEndDate) <= 0
                    ? 'Hết hạn'
                    : 'Còn ${Ultils.subcriptionEndDate(user.subscriptionEndDate)} ngày',
            style: kBodyStyle.copyWith(
                color: user.subscriptionEndDate.isNotEmpty &&
                        Ultils.subcriptionEndDate(user.subscriptionEndDate) > 0
                    ? AppColors.secondTextColor
                    : AppColors.red),
          ),
        ),
        Container(
          height: 70.h,
          alignment: Alignment.center,
          child: Text(
            user.subscriptionEndDate.isEmpty
                ? ''
                : Ultils.formatDateToString(user.subscriptionEndDate,
                    isShort: true),
            style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
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
                  // _showCreateOrUpdateBannerDialog(
                  //     type: ScreenType.update, bannerItem: bannerItem);
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
                  AppDialog.showWarningDialog(
                    context,
                    title: 'Xóa User'.toUpperCase(),
                    description: 'Xóa ${user.fullName}?',
                    confirmText: 'Xác nhận',
                    haveCancelButton: true,
                    onPressedComfirm: () {
                      // _handleDeleteBanner(tableID: bannerItem.id);
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
                color: AppColors.red,
                tooltip: 'Xóa',
              ),
            ),
          ],
        ),
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
                        child: ValueListenableBuilder<User>(
                          valueListenable: _user,
                          builder: (context, order, child) {
                            return ValueListenableBuilder(
                              valueListenable: _limit,
                              builder: (context, limit, child) => Text(
                                'Hiển thị 1 đến $limit trong số ${pagination.totalItem} user',
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
                          _fechData(limit: _limit.value, page: pageNumber);
                        },
                        fontSize: 16,
                        buttonElevation: 10,
                        buttonRadius: textFieldBorderRadius,
                        pageTotal: pagination.totalPage,
                        pageInit: _curentPage.value,
                        colorPrimary: context.colorScheme.primary,
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
}
