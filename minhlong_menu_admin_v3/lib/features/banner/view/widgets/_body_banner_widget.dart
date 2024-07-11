// part of '../screens/banner_screen.dart';

// extension _BodyBannerWidget on _BannerViewState {
//   Widget _bodyBannerWidget() {
//     return Container(
//       padding: const EdgeInsets.all(5).r,
//       decoration: BoxDecoration(
//         color: AppColors.white,
//         borderRadius: BorderRadius.circular(defaultBorderRadius).r,
//       ),
//       child: _tableWidget(),
//     );
//   }

//   Widget _tableWidget() {
//     return Column(
//       children: [
//         Container(
//           width: double.infinity,
//           height: 71,
//           alignment: Alignment.center,
//           child: Table(
//             columnWidths: const <int, TableColumnWidth>{
//               0: FixedColumnWidth(100),
//               1: FlexColumnWidth(),
//               2: FlexColumnWidth(),
//               3: FlexColumnWidth(),
//             },
//             defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//             children: <TableRow>[
//               _buildRowTitle(),
//             ],
//           ),
//         ),
//         Expanded(
//           child: BlocListener<CategoryBloc, CategoryState>(
//             listener: (context, state) {
//               // if (state is Cate) {
//               //   AppDialog.showLoadingDialog(context);
//               // }
//               // if (state is DinnerTableDeleteSuccess) {
//               //   Navigator.pop(context);
//               //   OverlaySnackbar.show(context, 'Xoá thành công');
//               //   _fetchDateDinnerTable(
//               //       page: _curentPage.value, limit: _limit.value);
//               // }
//               // if (state is DinnerTableFailure) {
//               //   Navigator.pop(context);
//               //   OverlaySnackbar.show(context, state.message,
//               //       type: OverlaySnackbarType.error);
//               // }
//             },
//             child: Builder(builder: (context) {
//               var categoryState = context.watch<CategoryBloc>().state;
//               switch (categoryState) {
//                 case CategoryFetchSuccess():
//                   context.read<PaginationCubit>().setPagination(
//                       categoryState.categoryModel.paginationModel!);
//                   return SingleChildScrollView(
//                       child: _buildWidgetSuccess(categoryState.categoryModel));

//                 case CategoryFetchFailure():
//                   return ErrWidget(error: categoryState.message);

//                 case CategoryFetchInProgress():
//                   return const Loading();

//                 case CategoryFetchEmpty():
//                   return Center(
//                     child: Text(
//                       'Không có dữ liệu',
//                       style:
//                           kBodyStyle.copyWith(color: AppColors.secondTextColor),
//                     ),
//                   );

//                 default:
//                   return const SizedBox();
//               }
//             }),
//           ),
//         ),

//         _buildBottomWidget()

//         // _buildBottomWidget(_orderModel.value)
//       ],
//     );
//   }

//   Widget _buildBottomWidget() {
//     return Builder(
//       builder: (context) {
//         var pagination = context.watch<PaginationCubit>().state;
//         return Container(
//           width: double.infinity,
//           height: 71,
//           padding: const EdgeInsets.all(10).r,
//           child: Row(
//             children: [
//               context.isMobile
//                   ? const SizedBox()
//                   : Expanded(
//                       child: FittedBox(
//                         alignment: Alignment.centerLeft,
//                         fit: BoxFit.scaleDown,
//                         child: ValueListenableBuilder<CategoryModel>(
//                           valueListenable: _categoryValueNotifier,
//                           builder: (context, order, child) {
//                             return ValueListenableBuilder(
//                               valueListenable: _limit,
//                               builder: (context, limit, child) => Text(
//                                 'Hiển thị 1 đến $limit trong số ${pagination.totalItem} món',
//                                 style: kBodyStyle.copyWith(
//                                   color: AppColors.secondTextColor,
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//               context.isDesktop ? const Spacer() : const SizedBox(),
//               Expanded(
//                 child: ValueListenableBuilder(
//                   valueListenable: _curentPage,
//                   builder: (context, value, child) {
//                     return Container(
//                       alignment: Alignment.centerRight,
//                       child: NumberPagination(
//                         onPageChanged: (int pageNumber) {
//                           _curentPage.value = pageNumber;
//                           _fetchCategory(limit: _limit.value, page: pageNumber);
//                         },
//                         fontSize: 16,
//                         buttonElevation: 10,
//                         buttonRadius: textFieldBorderRadius,
//                         pageTotal: pagination.totalPage,
//                         pageInit: _curentPage.value,
//                         colorPrimary: AppColors.themeColor,
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildWidgetSuccess(CategoryModel categoryModel) {
//     return Table(
//         // border: TableBorder.all(),
//         columnWidths: const <int, TableColumnWidth>{
//           0: FixedColumnWidth(100),
//           1: FlexColumnWidth(),
//           2: FlexColumnWidth(),
//           3: FlexColumnWidth(),
//         },
//         defaultVerticalAlignment: TableCellVerticalAlignment.middle,
//         children: categoryModel.categoryItems
//             .asMap()
//             .map(
//                 (index, value) => MapEntry(index, _buildRowTable(index, value)))
//             .values
//             .toList());
//   }

//   TableRow _buildRowTitle() {
//     return TableRow(
//       children: _listTitleTable
//           .map((e) => Text(
//                 e,
//                 textAlign: TextAlign.center,
//                 style: kBodyStyle.copyWith(
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.secondTextColor),
//               ))
//           .toList(),
//     );
//   }

//   TableRow _buildRowTable(int index, CategoryItem categoryItem) {
//     return TableRow(
//       decoration: BoxDecoration(
//         color:
//             index.isEven ? AppColors.black.withOpacity(0.1) : AppColors.white,
//       ),
//       children: <Widget>[
//         Container(
//           height: 70,
//           alignment: Alignment.center,
//           child: Container(
//             height: 60.h,
//             width: 60.h,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(textFieldBorderRadius).r),
//             clipBehavior: Clip.antiAlias,
//             child: CachedNetworkImage(
//               imageUrl: '${ApiConfig.host}${categoryItem.image}',
//               fit: BoxFit.contain,
//               errorWidget: errorBuilderForImage,
//             ),
//           ),
//         ),
//         Container(
//           height: 70.h,
//           alignment: Alignment.center,
//           child: Text(
//             categoryItem.name,
//             style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
//           ),
//         ),
//         Container(
//           height: 70.h,
//           alignment: Alignment.center,
//           child: Text(
//             categoryItem.serial.toString(),
//             style: kBodyStyle.copyWith(color: AppColors.secondTextColor),
//           ),
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: 70.h,
//               alignment: Alignment.center,
//               child: CommonIconButton(
//                 onTap: () {
//                   _showCreateOrUpdateCategoryDialog(
//                       type: CreateOrUpdateCategoryType.update,
//                       categoryItem: categoryItem);
//                 },
//                 icon: Icons.edit,
//                 color: AppColors.sun,
//                 tooltip: 'Chỉnh sửa',
//               ),
//             ),
//             10.horizontalSpace,
//             Container(
//               height: 70.h,
//               alignment: Alignment.center,
//               child: CommonIconButton(
//                 onTap: () {
//                   showDialog(
//                     context: context,
//                     builder: (context) => AppDialog(
//                       title: 'Xóa bàn',
//                       description: 'Xóa bàn ${categoryItem.name}?',
//                       confirmText: 'Xác nhận',
//                       onTap: () {
//                         _handleDeleteDinnerTable(tableID: categoryItem.id);
//                       },
//                     ),
//                   );
//                 },
//                 icon: Icons.delete_outline,
//                 color: AppColors.red,
//                 tooltip: 'Xóa bàn',
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Future<void> _showCreateOrUpdateCategoryDialog(
//       {required CreateOrUpdateCategoryType type,
//       CategoryItem? categoryItem}) async {
//     await showDialog(
//         context: context,
//         builder: (context) => Dialog(
//               backgroundColor: AppColors.background,
//               child: CreateOrUpdateCategory(
//                 type: type,
//                 categoryItem: categoryItem,
//               ),
//             )).then(
//       (value) {
//         if (value != null && value is bool) {
//           if (value) {
//             _fetchCategory(page: _curentPage.value, limit: _limit.value);
//           }
//         }
//       },
//     );
//   }

//   void _handleDeleteDinnerTable({required int tableID}) {
//     // context.pop();
//     // context.read<DinnerTableBloc>().add(DinnerTableDeleted(id: tableID));
//   }
// }
